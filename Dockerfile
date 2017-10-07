FROM nvidia/cuda:8.0-cudnn5-devel   
# start with the nvidia container for cuda 8 with cudnn 5

# forked from https://github.com/mjsobrep/DockerFiles-public
LABEL maintainer "Gary Feng <gary.feng@gmail.com>"

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install wget unzip lsof apt-utils lsb-core -y
RUN apt-get install libatlas-base-dev -y
RUN apt-get install libopencv-dev python-opencv python-pip -y   

RUN wget https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/master.zip; \
    unzip master.zip; rm master.zip

WORKDIR openpose-master
RUN sed -i 's/\<sudo chmod +x $1\>//g' ubuntu/install_caffe_and_openpose_if_cuda8.sh; \
    sed -i 's/\<sudo chmod +x $1\>//g' ubuntu/install_openpose_if_cuda8.sh; \
    sed -i 's/\<sudo -H\>//g' 3rdparty/caffe/install_caffe_if_cuda8.sh; \
    sed -i 's/\<sudo\>//g' 3rdparty/caffe/install_caffe_if_cuda8.sh; \
    sync; sleep 1; ./ubuntu/install_caffe_and_openpose_if_cuda8.sh
	