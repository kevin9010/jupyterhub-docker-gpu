FROM python:3.5

WORKDIR analysis

RUN pip install --upgrade pip && pip3 install jupyterhub && pip3 install --upgrade notebook
ADD jupyterhub_config.py /analysis/jupyterhub_config.py

RUN apt-get update -y && apt-get install npm nodejs-legacy -y
RUN npm install -g configurable-http-proxy

RUN useradd admin && echo admin:change.it! | chpasswd && mkdir /home/admin && chown admin:admin /home/admin

CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8888", "--no-ssl"]

EXPOSE 8888
