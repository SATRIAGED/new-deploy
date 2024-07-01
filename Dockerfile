FROM nginx as build
COPY --from=build index.html /usr/share/nginx/html