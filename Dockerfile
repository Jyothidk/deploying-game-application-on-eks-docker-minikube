FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/index.html

COPY 2048 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
