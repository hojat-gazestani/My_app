import socket

def gunicorn_port(request):
    port = request.META.get('SERVER_PORT', '')
    if port and ':' in request.get_host():
        port = request.get_host().split(':')[-1]
    return {'gunicorn_port': port}

