FROM ubuntu:18.04

WORKDIR /app/analysis

RUN apt-get upgrade -y && apt-get update -y && apt-get install -y python3-pip && pip3 install --upgrade pip
RUN apt-get install npm nodejs -y && \
    npm install -g configurable-http-proxy && \
    pip3 install jupyterhub && \
    pip3 install --upgrade notebook && \
    pip3 install pandas scipy matplotlib && \
    pip3 install "dask[distributed,dataframe]" && \    
    useradd admin && echo admin:change.it! | chpasswd && mkdir /home/admin && chown admin:admin /home/admin

ADD jupyterhub_config.py /app/analysis/jupyterhub_config.py
ADD create-user.py /app/analysis/create-user.py

CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8000", "--no-ssl"]

EXPOSE 8000
