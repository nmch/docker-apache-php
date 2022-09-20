FROM centos:6

RUN groupadd -g 500 webapp \
	&& useradd -u 500 -g 500 webapp

RUN sed -i "s|#baseurl=|baseurl=|g" /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i "s|http://mirror\.centos\.org/centos/\$releasever|https://vault\.centos\.org/6.10|g" /etc/yum.repos.d/CentOS-Base.repo

RUN yum install -y epel-release
RUN yum install -y https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-6-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum install -y which sudo python2-pip yum-utils msmtp
RUN yum-config-manager --disable pgdg94
RUN yum-config-manager --disable pgdg95
RUN yum-config-manager --disable pgdg96
RUN yum-config-manager --disable pgdg10
RUN yum-config-manager --disable pgdg11
RUN yum-config-manager --disable pgdg12
RUN yum install -y --enablerepo=pgdg12 postgresql12
RUN yum install -y nkf qpdf ImageMagick
RUN yum install -y php php-mbstring php-soap php-gd php-opcache php-tidy php-mcrypt php-xmlrpc php-bcmath php-pgsql php-pecl-imagick php-pecl-memcached php-pecl-memcache php-pecl-http
RUN yum install -y php-pecl-memcached php-pecl-memcache
RUN pear channel-discover pear.ethna.jp
RUN pear update-channels
RUN pear install -a ethna/ethna
