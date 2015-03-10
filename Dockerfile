FROM debian:wheezy

MAINTAINER Bruno Binet <bruno.binet@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV GOLANG_VERSION 1.4.2
ENV NODEJS_VERSION 0.12.0

RUN apt-get update && apt-get install -yq --no-install-recommends \
    initscripts curl tar gcc libc6-dev git ca-certificates \
    build-essential ruby ruby-dev rpm libfontconfig1 libfreetype6

RUN gem install fpm

ADD https://deb.nodesource.com/node012/pool/main/n/nodejs/nodejs_${NODEJS_VERSION}-1nodesource1~wheezy1_amd64.deb /tmp/nodejs.deb
RUN apt-get install -yq --no-install-recommends rlwrap
RUN dpkg -i /tmp/nodejs.deb && rm /tmp/nodejs.deb

RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
		| tar -v -C /usr/src -xz

RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

ADD run.sh /run.sh
RUN chmod +x /run.sh

WORKDIR /go/src/github.com/grafana/grafana

CMD ["/run.sh"]
