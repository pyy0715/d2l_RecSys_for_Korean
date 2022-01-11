FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

# Default Setting
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
RUN adduser --disabled-password --gecos "" d2l_student
WORKDIR /home/d2l_student


# Install base utilities
RUN apt-get update && \
    apt-get -y install curl unzip wget git && \
    apt-get clean


# Install zsh
RUN apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ENV SHELL /usr/bin/zsh


# install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "source activate base" >> ~/.zshrc


# install packages
RUN conda install -y pip && \
    pip install --upgrade pip && \
    pip install d2l && \
    pip install mxnet-cu101==1.7.0 && \
    pip install torch torchvision


# install jupyter_extensions
RUN pip install jupyter_nbextensions_configurator jupyter_contrib_nbextensions && \
    jupyter nbextensions_configurator enable && \
    jupyter contrib nbextension install


# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]


CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]