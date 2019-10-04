FROM centos

RUN yum update -y 
RUN yum install epel-release -y 
RUN yum update -y 
RUN yum -y install httpd httpd-tools php php-mysql php-fpm php-xml php-mbstring php-mcrypt php-xmlrpc php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php-memcached php-pear php-xml php-mbstring php-xdebug php-intl php-gd php-zip php-json libsodium
RUN yum -y install phpmyadmin

#Php7 Setup
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;
RUN yum -y install epel-release yum-utils;
RUN yum-config-manager --disable remi-php54;
RUN yum-config-manager --enable remi-php73;
RUN yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json;



RUN echo '<?php echo "Hello Getir! I am running on: "; echo gethostname(); ?>' > /var/www/html/index.php


EXPOSE  80
CMD     ["/usr/sbin/httpd","-D","FOREGROUND"]
