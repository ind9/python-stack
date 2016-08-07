FROM ubuntu:14.04.4

RUN locale-gen en_US.UTF-8

ENV USER_ID=999 \
    GROUP_ID=999

ENV LANG=en_US.UTF-8    \
    LANGUAGE=en_US:en   \
    LC_ALL=en_US.UTF-8

RUN apt-get update  \
    && apt-get -y install coreutils curl tar git-core daemontools gcc g++ python

RUN curl --silent http://dl.gliderlabs.com/herokuish/latest/linux_x86_64.tgz \
    | tar -xzC /bin

COPY mesos-fix /bin/mesos-fix
COPY build-slug /bin/build-slug

RUN /bin/herokuish buildpack install  \
    && chmod +x /bin/mesos-fix  \
    && chmod +x /bin/build-slug

CMD /bin/build-slug
