FROM nginx:alpine
RUN sed -i -e 's/101/900/g' /etc/group  \
    && sed -i -e 's/101/900/g' /etc/passwd \
    && sed -i -e 's:/var/run/nginx.pid:/tmp/nginx.pid:g' /etc/nginx/nginx.conf \
    && chown nginx:nginx -R /var/log/nginx /var/cache/nginx 
USER nginx
