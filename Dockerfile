FROM centos:7

ARG TARGETARCH
ENV ARCH "${TARGETARCH}"

RUN yum install -y epel-release \
	&& curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
	&& curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
	&& yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
	&& yum install -y https://repo.ius.io/ius-release-el7.rpm

RUN set -xe ; \
    pgdg_base_url="https://download.postgresql.org/pub/repos/yum/reporpms" ; \
    wkhtmltox_base_url="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5-1.centos7" ; \
    case $ARCH in \
        amd64) \
            rpm -i "${pgdg_base_url}/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm" ;; \
            rpm -i "${wkhtmltox_base_url}.x86_64.rpm" ;; \
        arm64) \
            rpm -i "${pgdg_base_url}/EL-8-aarch64/pgdg-redhat-repo-latest.noarch.rpm" ;; \
            rpm -i "${wkhtmltox_base_url}.aarch64.rpm" ;; \
        *) \
            exit 1 ;; \
    esac ;

RUN yum-config-manager --enable remi,remi-php80 \
	&& yum-config-manager --disable remi-safe \
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
