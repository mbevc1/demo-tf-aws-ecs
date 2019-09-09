FROM nginx:latest
LABEL maintainer="Marko <marko@scalefactory.com>"

RUN echo "<html> <head> <title>TeSt App</title> <style>body {margin-top: 40px; background-color: #337852;} </style> </head><body> <div style=color:white;text-align:center> <h1>TeSt App</h1> <h2>Welcome EDinburgh DevOps Meetup!</h2> <p>Application is running on a container in Amazon ECS.</p> </div></body></html>" \
> /usr/share/nginx/html/index.html
