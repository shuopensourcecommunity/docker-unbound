FROM shuosc/ubuntu:latest

MAINTAINER zhonger <zhonger@live.cn>

# install dependences
RUN echo y | apt-get install wget build-essential make libtool autoconf libssl-dev expat libexpat1-dev unzip supervisor && mkdir /root/downloads

# install libsolium library
RUN cd /root/downloads && wget -c https://ftp.shu.aixinwu.org/linuxsoftware/libsodium-1.0.15.tar.gz && tar xzf libsodium-1.0.15.tar.gz && cd libsodium-1.0.15 && ./configure && ./autogen.sh && ./configure && make -j4 && make install && ldconfig

# install libevent library
RUN cd /root/downloads && wget -c https://ftp.shu.aixinwu.org/linuxsoftware/libevent-2.1.8-stable.tar.gz && tar xzf libevent-2.1.8-stable.tar.gz && cd libevent-2.1.8-stable && ./configure --prefix=/usr && ./autogen.sh && ./configure && make -j4 && make install && echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf && ldconfig

# install dnscrypt-proxy
RUN cd /root/downloads && wget -c https://ftp.shu.aixinwu.org/linuxsoftware/dnscrypt-proxy-1.9.5.tar.gz && tar xzf dnscrypt-proxy-1.9.5.tar.gz && cd dnscrypt-proxy-1.9.5 && ./configure && make -j4 && make install 
ADD ./dnscrypt-proxy.conf /usr/local/etc/dnscrypt-proxy.conf

# install unbound
RUN cd /root/downloads && wget -c https://ftp.shu.aixinwu.org/linuxsoftware/unbound-1.6.7.tar.gz && tar xzf unbound-1.6.7.tar.gz && cd unbound-1.6.7 && ./configure --with-libevent && make -j4 && make install && useradd unbound  && rm -rf /root/downloads


VOLUME [ "/usr/local/etc/unbound/" ]
VOLUME [ "/etc/supervisor/" ]

EXPOSE 53

# Define default command.
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

