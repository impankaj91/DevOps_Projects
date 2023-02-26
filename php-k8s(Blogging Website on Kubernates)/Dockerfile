FROM ubuntu

ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive

RUN apt update -y 

RUN apt-get install tzdata
    # apt install -y apache && \
    # apt-get -y install sudo && \
    # apt-get install ufw

RUN apt -qq -y install apache2 

RUN apt-get install ufw -y

RUN ufw allow in "Apache"

RUN apt install php libapache2-mod-php php-mysql -y

RUN php -v

RUN rm -rf /var/www/html/index.html
COPY ./ /var/www/html

EXPOSE 8080
CMD ["apachectl", "-D", "FOREGROUND"]


#CMD ["php","-S","0.0.0.0:80"]
