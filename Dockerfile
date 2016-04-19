FROM ubuntu:14.04.4

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update  \
    && apt-get -y install coreutils curl tar git-core daemontools gcc g++ python
RUN curl --silent http://dl.gliderlabs.com/herokuish/latest/linux_x86_64.tgz \
    | tar -xzC /bin \
    && /bin/herokuish buildpack install https://github.com/heroku/heroku-buildpack-python v80
CMD /bin/herokuish buildpack build && /bin/herokuish slug generate && /bin/herokuish slug export > /app/app.tar.gz
