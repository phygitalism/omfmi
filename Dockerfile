FROM phygitalism/openmodelica:1.0

RUN apt-get update -y && \
    apt-get install -y curl bzip2 && \
    apt-get clean

SHELL ["/bin/bash", "-c"]

# Install Anaconda
RUN curl https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh --progress-bar -o ~/anaconda.sh && \
    chmod +x ~/anaconda.sh && \
    ~/anaconda.sh -b -p /opt/conda && \
    source /opt/conda/bin/activate && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH
RUN conda update -y conda

RUN conda create -n py35 python=3.5 anaconda -y && \
    echo 'source activate py35' >> ~/.bashrc

RUN source activate py35 && \
    conda install -c conda-forge fmilib && \
    conda install -c chria pyfmi

RUN apt-get update -y && apt-get install -y libgfortran3 libopenblas-dev libopenblas-base && \
    apt-get update -y && apt-get install -y libblas3 libblas-dev liblapack3 liblapack-dev liblapacke-dev && \
    apt-get update -y && apt-get install -y --reinstall gfortran && apt-get clean && \
    export LD_LIBRARY_PATH=usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Create an user and an environmental variable associated to it
ENV USER=phygitalism
RUN adduser --disabled-password --gecos '' ${USER} && \
    adduser ${USER} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

CMD ["/bin/bash"]
