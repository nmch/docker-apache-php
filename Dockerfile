FROM centos:6

RUN groupadd -g 500 webapp \
	&& useradd -u 500 -g 500 webapp \
	&& sed -i "s|#baseurl=|baseurl=|g" /etc/yum.repos.d/CentOS-Base.repo \
	&& sed -i "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-Base.repo \
	&& sed -i "s|http://mirror\.centos\.org/centos/\$releasever|https://vault\.centos\.org/6.10|g" /etc/yum.repos.d/CentOS-Base.repo \
	&& yum install -y epel-release \
	&& yum install -y https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-6-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
	&& yum install -y which sudo python2-pip yum-utils msmtp \
	&& yum-config-manager --disable pgdg94 \
	&& yum-config-manager --disable pgdg95 \
	&& yum-config-manager --disable pgdg96 \
	&& yum-config-manager --disable pgdg10 \
	&& yum-config-manager --disable pgdg11 \
	&& yum-config-manager --disable pgdg12 \
	&& yum install -y --enablerepo=pgdg12 postgresql12 \
	&& yum install -y nkf qpdf ImageMagick \
	&& yum install -y php php-mbstring php-soap php-gd php-opcache php-tidy php-mcrypt php-xmlrpc php-bcmath php-pgsql php-pecl-imagick php-pecl-memcached php-pecl-memcache php-pecl-http \
	&& yum install -y php-pecl-memcached php-pecl-memcache \
	&& pear channel-discover pear.ethna.jp \
	&& pear update-channels \
	&& pear install -a ethna/ethna \
	&& yum clean all \
	&& rm -rf /var/cache/yum

ADD --chown=500:500 https://browscap.org/stream?q=PHP_BrowsCapINI /usr/local/etc/browscap.ini
