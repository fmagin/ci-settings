FROM ubuntu:xenial
USER root
WORKDIR /root
RUN chmod 755 .

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential python3 \
    python3-dev python3-pip python3-setuptools python3-wheel zip git \
    libffi-dev libtool libtool-bin wget automake bison cmake nasm clang socat \
    libglib2.0-dev libc6:i386 libgcc1:i386 libstdc++6:i386 libtinfo5:i386 \
    zlib1g:i386 gdb gdbserver openjdk-8-jdk-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install virtualenv pygithub

RUN umask 0; git clone --depth=1 https://github.com/angr/wheels.git
ADD scripts ./scripts
ADD conf ./conf
