FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Olivier Harismendy "oharismendy@ucsd.edu"

### change a working directory to /opt #######
WORKDIR /opt

### install
RUN apt-get update && apt-get install -y \
autoconf \
build-essential \
curl \
git \
g++ \
libncurses5-dev \
libssl-dev \
libboost-all-dev \
libbz2-dev \
make \
man \
pkg-config \
python \
python-pip \
python-dev \
software-properties-common \
screen \
vim \
wget \
zip \
zlibc \
zlib1g \
zlib1g-dev

RUN wget https://repo.continuum.io/archive/Anaconda2-4.1.1-MacOSX-x86_64.sh &&\
    bash Anaconda2-4.1.1-MacOSX-x86_64.sh -b -p /usr/bin/anaconda 

RUN conda install variant_tools \
 numpy \
 scikit-bio \
 scipy \
 statsmodels \
 pandas \
 matplotlib

RUN git clone https://github.com/marcelm/cutadapt.git && \
 	cd /cutadapt/ && python setup.py install && python setup.py build_ext -i $$\
 	make &&\
 cp cutadapt /usr/bin

WORKDIR /opt

RUN git clone https://github.com/BenLangmead/bowtie2.git &&\
 cd bowtie2 $$\
 make &&\
 cp bowtie2 /usr/bin &&\
 cp bowtie2-align-s /usr/bin &&\
 cp bowtie2-align-l /usr/bin &&\
 cp bowtie2-build /usr/bin &&\
 cp bowtie2-build-s /usr/bin &&\
 cp bowtie2-build-l /usr/bin &&\
 cp bowtie2-inspect /usr/bin &&\
 cp bowtie2-inspect-s /usr/bin &&\
 cp bowtie2-inspect-l /usr/bin &&\


WORKDIR /opt

RUN chmod a+x /usr/local/bin/*

RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu


CMD ["/bin/bash"]
