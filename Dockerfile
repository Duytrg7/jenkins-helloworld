FROM nginx:alpine
#checkov:skip=CKV_DOCKER_3: nginx needs root to bind port 80
COPY index.html /usr/share/nginx/html/index.html
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://localhost/ || exit 1
