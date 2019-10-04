FROM centos

RUN yum update -y 
RUN yum -y install httpd httpd-tools 

#Php Setup
RUN yum -y install php;

RUN echo 'Hello Getir' > /var/www/html/index.html

EXPOSE  80
CMD     ["/usr/sbin/httpd","-D","FOREGROUND"]
