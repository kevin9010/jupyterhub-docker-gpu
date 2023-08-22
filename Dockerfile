FROM nvidia/cuda:11.0.3-base-ubuntu20.04

WORKDIR /app/analysis

ENV TZ=Asia/shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN sed -i s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list && \
    sed -i s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list && \
    apt-get update -y && apt-get upgrade -y

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install tzdata

RUN apt-get upgrade -y && apt-get update -y && apt-get install -y python3-pip && pip3 install --upgrade pip

RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U && \
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
	
RUN apt-get install -y curl
	
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
    apt-get install -y nodejs && \
    npm install -g configurable-http-proxy
    
RUN pip3 cache purge && \
    pip3 install jupyterhub && \
    pip3 install --upgrade notebook && \
    pip3 install jupyterlab-language-pack-zh-CN && \
    pip3 install pandas scipy matplotlib && \
    pip3 install "dask[distributed,dataframe]" && \   
    pip3 install dask_labextension && \
    pip3 install torch torchvision torchaudio && \
    pip3 cache purge
    
RUN useradd shu && echo shu:12345678! | chpasswd && mkdir /home/shu && chown shu:shu /home/shu
	
RUN apt-get clean -y && apt-get autoclean -y
RUN rm -rf /var/lib/apt/lists/* /var/log/* /var/tmp/* ~/.npm
ADD jupyterhub_config.py /app/analysis/jupyterhub_config.py
ADD create-new-user.py /app/analysis/create-new-user.py

CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8000", "--no-ssl"]

EXPOSE 8000
