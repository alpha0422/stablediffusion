ARG FROM_IMAGE_NAME=gitlab-master.nvidia.com:5005/dl/dgx/pytorch:master-py3-devel

FROM ${FROM_IMAGE_NAME}

RUN apt-get update && \
    apt-get install -y libsm6 libxext6 libxrender-dev && \
    rm /var/lib/apt/lists/* -rf

COPY requirements.txt /workspace/stable-diffusion/requirements.txt
RUN pip install --ignore-installed PyYAML
RUN pip install -r /workspace/stable-diffusion/requirements.txt

COPY . /workspace/stable-diffusion
WORKDIR /workspace/stable-diffusion
RUN pip install -e .
