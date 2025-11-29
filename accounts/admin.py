from django.contrib import admin

from .models import UserProfile


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'country', 'home_city', 'preferred_language', 'created_at')
    search_fields = ('user__username', 'country', 'home_city')
