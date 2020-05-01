FROM ubuntu:focal

# EXPOSE 6667

WORKDIR /build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update && \
    apt-get -qy dist-upgrade && \
    apt-get -qy install bitlbee-dev bitlbee-libpurple libpurple-dev \
        gcc \
        gettext \
        git \
        libgcrypt20-dev \
        libpng-dev \
        libwebp-dev \
        make \
        pkg-config \
        zlib1g-dev

RUN git clone --recursive https://github.com/majn/telegram-purple && \
    cd telegram-purple && \
    ./configure && \
    make && \
    make install && \
    cd ..

RUN apt-get -qy install \
        build-essential \
        libglib2.0-dev \
        libjson-glib-dev \
        libmarkdown2-dev && \
    git clone https://github.com/EionRobb/purple-mattermost.git && \
    cd purple-mattermost && \
    make && \
    make install
        

RUN apt-get -qy --purge remove git autoconf && \
    apt-get -qy --purge autoremove && \
    rm -rf /build

COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
