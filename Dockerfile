FROM centos:7

ARG TARGETARCH

RUN yum install -y epel-release \
	&& curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
	&& curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
	&& yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN set -xe ; \
    case "${TARGETARCH}" in \
        amd64) ARCH="x86_64" ;; \
        arm64) ARCH="aarch64" ;; \
        *) exit 2 ;; \
    esac ; \
	yum-config-manager --enable remi,remi-php80 \
	&& yum-config-manager --disable remi-safe \
    && yum install -y "https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-${ARCH}/pgdg-redhat-repo-latest.noarch.rpm" \
    && yum install -y "https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.${ARCH}.rpm" \
	&& yum install -y nodejs yarn \
	&& yum install -y which sudo python3-pip tmpwatch zip unzip git msmtp jq ghostscript wget \
	&& yum install -y httpd24u httpd24u-mod_ssl \
	&& yum install -y postgresql13 \
	&& yum install -y php php-mbstring php-soap php-gd php-opcache php-tidy php-mcrypt php-xmlrpc php-bcmath php-pgsql php-pecl-imagick php-pecl-http php-pear-XML-RPC php-pecl-zip php-pear-Mail-mimeDecode php-pecl-memcached \
	&& yum install -y php-pecl-mongodb php-pecl-redis5 php-pecl-oauth php-pecl-uuid \
	&& yum install -y nkf qpdf \
	&& yum install -y ipa-gothic-fonts ipa-pgothic-fonts \
	&& yum update -y \
	&& sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/yum.conf \
	&& yum -y reinstall glibc-common \
	&& yum clean all \
	&& rm -rf /var/cache/yum \
	&& pip3 install awscli \
	&& chown apache:apache /var/lib/php/session

ADD --chown=500:500 https://browscap.org/stream?q=PHP_BrowsCapINI /usr/local/etc/browscap.ini
