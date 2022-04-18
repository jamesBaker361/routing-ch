# syntax=docker/dockerfile:1
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && apt-get install -y -f \
	build-essential \
	wget \
	scons \
	rsync \
	libboost-all-dev \
	libcairo2-dev \
	libnuma-dev \ 
	libproj-dev \
	libtbb-dev \
	git-all \
	zlib1g-dev \
	cmake \
	gdb \
	lemon \
	python3 \
	python3-pip \
    python3-dev 

RUN python3 -m pip install numpy \
	scipy \
	networkx \
	OpenMatrix \
	decorator \
	pandas \
	networkx \
	pytest \
	pybind11 \
	gym==0.22.0 \
	typing-extensions \
	setuptools \
	tune \
	ray[rllib] \
	tensorflow \
	tensorboard


SHELL ["/bin/bash", "-c"]
COPY routing-framework routing-framework
WORKDIR routing-framework/External

RUN git clone https://github.com/RoutingKit/RoutingKit.git
RUN git clone https://github.com/ben-strasser/fast-cpp-csv-parser.git
RUN git clone https://github.com/vectorclass/version2.git

RUN git clone https://github.com/pybind/pybind11.git
RUN cd pybind11 && mkdir build && cd build && cmake ..

RUN cd fast-cpp-csv-parser && cp *.h /usr/local/include && cd ..
RUN cd RoutingKit && make && cp -r include lib /usr/local && cd ..
#RUN cd vectorclass && mkdir /usr/local/include/vectorclass && cp *.h special/* $_ && cd .. && cd ..