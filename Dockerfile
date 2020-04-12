FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel
ARG TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX 7.5+PTX"

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    cmake \
    unzip \
    build-essential \
    libsm6 \
    libxext6 \
    libfontconfig1 \
    libxrender1 \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libpq-dev \
    libturbojpeg \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --no-cache-dir \
    numpy \
    pandas \
    PyYAML \
    cycler \
    dill \
    h5py \
    imgaug \
    matplotlib \
    opencv-contrib-python \
    Pillow \
    scikit-image \
    scikit-learn \
    scipy \
    setuptools \
    six \
    tqdm \
    ipython \
    ipdb \
    albumentations \
    click \
    jpeg4py \
    addict \
    colorama \
    torchvision \
    iterative-stratification

RUN pip install --upgrade --no-cache-dir cython && pip install --no-cache-dir pycocotools==2.0.0 mmcv==0.2.5

RUN git clone  --recursive https://github.com/sh1ng/kaggle-imaterialist.git && \
    cd kaggle-imaterialist/mmdetection && \
    bash compile.sh && \
    python setup.py develop