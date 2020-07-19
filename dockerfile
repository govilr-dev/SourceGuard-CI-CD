FROM ubuntu:latest
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install apache2 -y 
RUN service apache2 start 
COPY content.html /var/www/html
COPY upload.php /var/www/html
RUN  apt install iputils-ping -y
RUN ping -c 3 72.26.218.70
