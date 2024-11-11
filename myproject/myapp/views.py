from django.shortcuts import render
from django.http import HttpResponse
import socket
from myproject.context_processors import gunicorn_port


hostname = socket.gethostname()

def app(request):
    return HttpResponse(f"Application test on {hostname}, Gunicorn port: { gunicorn_port(request)}")
    
def app1(request):
    return HttpResponse(f"app1 on {hostname}, Gunicorn port: { gunicorn_port(request)}")
    
def app2(request):
    return HttpResponse(f"app2 on {hostname}, Gunicorn port: { gunicorn_port(request)}")
