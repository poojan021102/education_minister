"""moe URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views
urlpatterns = [
    path('admin/', admin.site.urls),
    path('',views.main_page,name="main_page"),
    path('party',views.Party,name="Party"),
    path('insert_party',views.insert_party,name="insert_party"),
    path('delete_party/<int:id>',views.delete_party,name="delete_party"),
    path('minister',views.Minister,name="Minister"),
    path('school',views.School,name = "School"),
    path('Student',views.Student,name = "Student"),
    path('delete_student/<int:id>',views.delete_student,name="delete_student"),
    path('edit_student/<int:id>',views.edit_student,name="edit_student"),
    path('insert_student',views.insert_student,name = "insert_student"),
]
