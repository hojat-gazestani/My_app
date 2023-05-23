from django.urls import path
from . import views

urlpatterns = [
    path('', views.app, name='app'),
    path('app/', views.app, name='app'),
    path('app1/', views.app1, name='app1'),
    path('app2/', views.app2, name='app'),
]
