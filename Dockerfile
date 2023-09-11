FROM ubuntu:22.04 AS libs
WORKDIR /mariadbpp
RUN apt update && apt install -y build-essential cmake pkg-config g++ git autoconf libmariadb-dev-compat libgcrypt20-dev
RUN cd / && git clone https://github.com/viaduck/mariadbpp.git
RUN git submodule update --init
RUN mkdir build
WORKDIR /mariadbpp/build
RUN cmake ..
RUN make install
RUN cd / && git clone https://github.com/paolostivanin/libbaseencode.git
WORKDIR /libbaseencode/build
RUN cmake ../
RUN make
RUN make install
RUN cd / && git clone -b v1.2.8 https://github.com/paolostivanin/libcotp.git
WORKDIR /libcotp/build
RUN cmake ../
RUN make
RUN make install

FROM ubuntu:22.04

# Avoid any UI since we don't have one
ENV DEBIAN_FRONTEND=noninteractive

# Update and install all requirements as well as some useful tools such as net-tools and nano
RUN apt update && apt install -y net-tools nano build-essential software-properties-common libzmq3-dev luarocks python-is-python3 cmake pkg-config g++ dnsutils git mariadb-server libluajit-5.1-dev libzmq3-dev autoconf zlib1g-dev libssl-dev python3-dev libmariadb-dev-compat librabbitmq-dev libgcrypt20-dev

COPY --from=libs /usr/local/lib /usr/local/lib
COPY --from=libs /usr/local/include /usr/local/include

RUN echo /usr/local/lib >/etc/ld.so.conf.d/wings.conf && ldconfig

RUN useradd wings

# Working directory will be /wings meaning that the contents of wings will exist in /wings
WORKDIR /wings

# Copy everything from the host machine wings folder to /wings
ADD . /wings
RUN chown -R wings:wings /wings

USER wings

RUN mkdir build && cd build && cmake .. && make -j $(nproc) && cd .. && rm -r /wings/build

# Copy the docker config files to the conf folder instead of the default config
COPY /conf/default/* conf/

# Ensure wait_for_db_then_launch.sh is executable
RUN chmod +x ./tools/wait_for_db_then_launch.sh

# Startup the server when the container starts
ENTRYPOINT ./tools/wait_for_db_then_launch.sh
