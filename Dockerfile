FROM debian:latest
MAINTAINER "enumus"

# Install requirements
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-wsgi-py3 \
    build-essential \
    python3 \
    python3-dev\
    python3-pip \
    vim \
    git \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/enumus/py-mikrotik-reporter.git /app

# Configuring apache
COPY ./apache.tpl /etc/apache2/sites-available/main.conf
RUN a2dissite 000-default.conf \
    & a2ensite main.conf \
    & a2enmod headers

RUN pip3 install --upgrade pip
RUN pip3 install -r /app/requirements.txt

RUN mv /app/config.tpl /app/config.ini

# LINK apache config to docker logs.
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

# Set working directory
WORKDIR /app

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND