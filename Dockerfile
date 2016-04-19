FROM ubuntu:14.04.4

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV BUILDPACK_URL https://github.com/ind9/mesos-buildpack-python
ENV BUILDPACK_COMMIT mesos-fix

RUN apt-get update  \
    && apt-get -y install coreutils curl tar git-core daemontools gcc g++ python
RUN curl --silent http://dl.gliderlabs.com/herokuish/latest/linux_x86_64.tgz \
    | tar -xzC /bin

CMD /bin/herokuish buildpack install ${BUILDPACK_URL} ${BUILDPACK_COMMIT} && /bin/herokuish buildpack build && /bin/herokuish slug generate && /bin/herokuish slug export > /app/app.tar.gz
