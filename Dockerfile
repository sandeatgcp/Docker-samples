FROM ubuntu:12.04 

# Install dependencies
RUN apt-get update -y

RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-17.03.0-ce.tgz \
  && tar xzvf docker-17.03.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.03.0-ce.tgz



RUN apt-get install -y apache2

# Install apache2 and write “welcome to my container” message
RUN echo " Welcome to my container... Jenkins updated your application with new version" > /var/www/index.html

# Configure Apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80 
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
