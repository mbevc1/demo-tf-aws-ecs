FROM nginx:latest
LABEL maintainer="Marko <marko@scalefactory.com>"

RUN echo "Hello from EDiburgh Devops Meetup!" > /usr/share/nginx/html/index.html
