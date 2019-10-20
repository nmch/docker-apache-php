FROM centos:7

RUN yum install -y epel-release \
	&& curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
	&& curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
	&& yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
	&& yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
	&& yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm \
	&& yum-config-manager --enable remi,remi-php73 \
	&& yum-config-manager --disable remi-safe \
	&& yum install -y nodejs yarn \
	&& yum install -y which sudo python2-pip tmpwatch unzip git msmtp \
	&& yum install -y httpd24u \
	&& yum install -y postgresql10 \
	&& yum install -y php php-mbstring php-soap php-gd php-opcache php-tidy php-mcrypt php-xmlrpc php-bcmath php-pgsql php-pecl-imagick php-pecl-http php-pear-XML-RPC php-pecl-zip php-pear-Mail-mimeDecode php-pecl-memcached \
	&& yum install -y php73-php-pecl-mongodb \
	&& yum install -y nkf qpdf \
	&& yum install -y ipa-gothic-fonts ipa-pgothic-fonts \
	&& yum update -y \
	&& sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/yum.conf \
	&& yum -y reinstall glibc-common \
	&& yum clean all \
	&& rm -rf /var/cache/yum \
	&& pip install --upgrade pip awscli
