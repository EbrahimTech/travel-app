from rest_framework import serializers

from .models import Category, City, Place, PlaceImage, Post, Review


class CitySerializer(serializers.ModelSerializer):
    class Meta:
        model = City
        fields = '__all__'


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class PlaceImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlaceImage
        fields = '__all__'


class PlaceSerializer(serializers.ModelSerializer):
    city = CitySerializer(read_only=True)
    category = CategorySerializer(read_only=True)
    images = PlaceImageSerializer(many=True, read_only=True)

    class Meta:
        model = Place
        fields = '__all__'


class ReviewSerializer(serializers.ModelSerializer):
    user_name = serializers.SerializerMethodField()

    class Meta:
        model = Review
        fields = '__all__'

    def get_user_name(self, obj):
        return obj.user.username


class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'
