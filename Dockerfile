FROM r-base:4.0.0
#FROM jupyter/datascience-notebook:r-3.6.2
RUN apt-get update
RUN apt-get install -y libssl-dev curl libcurl4-openssl-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev software-properties-common python3 python3-distutils 
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN pip install jupyterlab

RUN echo 'install.packages(c("repr", "IRkernel", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest", "dplyr","ggplot2","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'install.packages(c("uuid", "digest","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'install.packages(c("matlib", "Matrix","Seurat"),repos="http://cran.r-project.org" )' | R --no-save

RUN echo 'IRkernel::installspec()' | R --no-save  

WORKDIR /R-SHARED
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--port=9999", "--allow-root", "--no-browser", "--NotebookApp.token=''","--NotebookApp.password=''"]
