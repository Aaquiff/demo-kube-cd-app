FROM nginx:latest

COPY web-content/index.html /usr/share/nginx/html/index.html
COPY web-content/DockerFileEx.jpg /usr/share/nginx/html/DockerFileEx.jpg

EXPOSE 80