from rest_framework.routers import DefaultRouter

from .views import (
    CategoryViewSet,
    CityViewSet,
    PlaceViewSet,
    PostViewSet,
    ReviewViewSet,
)

app_name = 'places'

router = DefaultRouter()
router.register('cities', CityViewSet, basename='city')
router.register('categories', CategoryViewSet, basename='category')
router.register('places', PlaceViewSet, basename='place')
router.register('reviews', ReviewViewSet, basename='review')
router.register('posts', PostViewSet, basename='post')

urlpatterns = router.urls
