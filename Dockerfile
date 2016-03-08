FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# update apt
RUN apt-get update && apt-get -y install build-essential git
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/local/src/
RUN git clone https://github.com/numberly/beanstalkd.git
WORKDIR /usr/local/src/beanstalkd

RUN make CFLAGS=-O2
RUN make install

VOLUME ["/data"]
EXPOSE 11300
WORKDIR /
CMD ["/usr/bin/beanstalkd", "-f", "60000", "-b", "/data"]
