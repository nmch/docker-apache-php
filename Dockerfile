FROM centos:7

RUN yum install -y epel-release \
	&& curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
	&& curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
	&& yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
	&& yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
	&& yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
	&& yum install -y https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm \
	&& yum-config-manager --enable remi,remi-php74 \
	&& yum-config-manager --disable remi-safe \
	&& yum install -y nodejs yarn \
	&& yum install -y which sudo python2-pip tmpwatch unzip git msmtp jq ghostscript \
	&& yum install -y httpd24u \
	&& yum install -y postgresql12 \
	&& yum install -y php php-mbstring php-soap php-gd php-opcache php-tidy php-mcrypt php-xmlrpc php-bcmath php-pgsql php-pecl-imagick php-pecl-http php-pear-XML-RPC php-pecl-zip php-pear-Mail-mimeDecode php-pecl-memcached \
	&& yum install -y php74-php-pecl-mongodb \
	&& yum install -y nkf qpdf \
	&& yum install -y ipa-gothic-fonts ipa-pgothic-fonts \
	&& yum update -y \
	&& sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/yum.conf \
	&& yum -y reinstall glibc-common \
	&& yum clean all \
	&& rm -rf /var/cache/yum \
	&& pip install --upgrade pip awscli \
	&& curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
	&& chmod 755 /usr/local/bin/go-cron
