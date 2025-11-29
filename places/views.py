from django.db.models import Q
from rest_framework import permissions, serializers, viewsets

from .models import Category, City, Place, Post, Review
from .serializers import (
    CategorySerializer,
    CitySerializer,
    PlaceSerializer,
    PostSerializer,
    ReviewSerializer,
)


class ReadOnlyModelViewSet(viewsets.ModelViewSet):
    http_method_names = ['get', 'head', 'options']


class CityViewSet(ReadOnlyModelViewSet):
    queryset = City.objects.all().order_by('name')
    serializer_class = CitySerializer
    permission_classes = [permissions.AllowAny]


class CategoryViewSet(ReadOnlyModelViewSet):
    queryset = Category.objects.all().order_by('name')
    serializer_class = CategorySerializer
    permission_classes = [permissions.AllowAny]


class PlaceViewSet(viewsets.ModelViewSet):
    serializer_class = PlaceSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = (
            Place.objects.filter(is_active=True)
            .select_related('city', 'category')
            .prefetch_related('images')
        )
        city_slug = self.request.query_params.get('city')
        category_slug = self.request.query_params.get('category')
        search = self.request.query_params.get('search')

        if city_slug:
            queryset = queryset.filter(city__slug=city_slug)
        if category_slug:
            queryset = queryset.filter(category__slug=category_slug)
        if search:
            queryset = queryset.filter(
                Q(name__icontains=search) | Q(description__icontains=search)
            )

        return queryset


class ReviewViewSet(viewsets.ModelViewSet):
    serializer_class = ReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = Review.objects.select_related('user', 'place')
        place_id = self.request.query_params.get('place')
        if place_id:
            queryset = queryset.filter(place_id=place_id)
        return queryset

    def perform_create(self, serializer):
        rating = serializer.validated_data.get('rating')
        if rating is not None and not 1 <= rating <= 5:
            raise serializers.ValidationError({'rating': 'Rating must be between 1 and 5.'})
        serializer.save(user=self.request.user)


class PostViewSet(viewsets.ModelViewSet):
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    queryset = Post.objects.select_related('user', 'city').order_by('-created_at')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
