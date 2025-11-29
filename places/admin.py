from django.contrib import admin

from .models import Category, City, Place, PlaceImage, Post, Review


@admin.register(City)
class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'country', 'created_at')
    search_fields = ('name', 'country')


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'icon')
    search_fields = ('name', 'slug')


class PlaceImageInline(admin.TabularInline):
    model = PlaceImage
    extra = 0


@admin.register(Place)
class PlaceAdmin(admin.ModelAdmin):
    list_display = ('name', 'city', 'category', 'avg_rating', 'total_reviews', 'is_active')
    list_filter = ('city', 'category', 'is_active')
    search_fields = ('name', 'description', 'address')
    inlines = [PlaceImageInline]


@admin.register(PlaceImage)
class PlaceImageAdmin(admin.ModelAdmin):
    list_display = ('place', 'image_url', 'is_cover', 'created_at')
    list_filter = ('is_cover',)


@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ('place', 'user', 'rating', 'created_at')
    list_filter = ('rating', 'created_at')
    search_fields = ('place__name', 'user__username', 'comment')


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'user', 'city', 'created_at')
    search_fields = ('title', 'content', 'city__name')
