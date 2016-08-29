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
python-numpy \
software-properties-common \
screen \
vim \
wget \
zip \
zlibc \
zlib1g \
zlib1g-dev


RUN pip install --upgrade pip &&\
    pip install scipy \
    statsmodels \
    pandas \
    matplotlib \
    cutadapt

RUN git clone https://github.com/BenLangmead/bowtie2.git &&\
 cd bowtie2 &&\
 make &&\
 cp bowtie2 /usr/bin &&\
 cp bowtie2-align-s /usr/bin &&\
 cp bowtie2-align-l /usr/bin &&\
 cp bowtie2-build /usr/bin &&\
 cp bowtie2-build-s /usr/bin &&\
 cp bowtie2-build-l /usr/bin &&\
 cp bowtie2-inspect /usr/bin &&\
 cp bowtie2-inspect-s /usr/bin &&\
 cp bowtie2-inspect-l /usr/bin

WORKDIR /opt

RUN groupadd -r -g 1000 ubuntu &&\
    useradd -r -g ubuntu -u 1000 -d /home/ubuntu ubuntu &&\
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
    chown -R ubuntu:ubuntu /home/ubuntu

USER ubuntu
WORKDIR /home/ubuntu

CMD ["/bin/bash"]
