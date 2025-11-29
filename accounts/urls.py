from django.urls import path

from .views import AccountsRootView, MeView

app_name = 'accounts'

urlpatterns = [
    path('', AccountsRootView.as_view(), name='accounts-root'),
    path('me/', MeView.as_view(), name='me'),
]
