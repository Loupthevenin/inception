FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y\
	nginx\
	openssl\
	&& apt clean

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=ltheveni/CN=ltheveni.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
