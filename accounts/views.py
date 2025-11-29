from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import UserProfileSerializer


class AccountsRootView(APIView):
    def get(self, request):
        return Response({'message': 'accounts endpoint placeholder'})


class MeView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        profile = getattr(user, 'profile', None)
        profile_data = UserProfileSerializer(profile).data if profile else None
        return Response(
            {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'profile': profile_data,
            }
        )
