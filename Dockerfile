FROM ubuntu:14.04.4

RUN locale-gen en_US.UTF-8

ENV USER_ID=999 \
    GROUP_ID=999

ENV LANG=en_US.UTF-8    \
    LANGUAGE=en_US:en   \
    LC_ALL=en_US.UTF-8  \
    BUILDPACK_URL=https://github.com/ind9/mesos-buildpack-python#mesos-fix

RUN apt-get update  \
    && apt-get -y install coreutils curl tar git-core daemontools gcc g++ python
RUN curl --silent http://dl.gliderlabs.com/herokuish/latest/linux_x86_64.tgz \
    | tar -xzC /bin
RUN /bin/herokuish buildpack install  # Install officially supported buildpacks

CMD addgroup --gid $GROUP_ID go \
    && adduser -q --disabled-password --gid $GROUP_ID --uid $USER_ID --gecos "" --shell /bin/bash --home /var/go go \
    && /bin/herokuish buildpack build \     # Install any custom version of buildpacks
    && /bin/herokuish slug generate \
    && /bin/herokuish slug export > /app/app.tar.gz \
    && chown -R go:go /app
