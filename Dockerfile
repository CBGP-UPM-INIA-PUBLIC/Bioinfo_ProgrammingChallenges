FROM jupyter/datascience-notebook:8312f54454d7
#FROM andrewosh/binder-base

MAINTAINER markw@illuminae.com

USER root

RUN apt-get update

RUN apt-get install -y aptitude

#RUN echo 'deb http://deb.debian.org/debian jessie-backports main contrib non-free' >> /etc/apt/sources.list
#RUN echo 'deb http://deb.debian.org/debian jessie-backports-sloppy main contrib non-free' >> /etc/apt/sources.list

#RUN aptitude update
#RUN apt-get install -y -t jessie-backports r-base r-base-dev


RUN apt-get update
#RUN apt-get install -y libcurl4-openssl-dev libssl-dev 
RUN apt-get install -y software-properties-common


RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.4.0


RUN apt-get install -y build-essential libcurl4-openssl-dev libssl-dev libtool autoconf automake && apt-get clean
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385



# RUN echo 'install.packages(c("repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest", "dplyr","ggplot2","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'install.packages(c("uuid", "digest","gapminder"),repos="http://cran.r-project.org" )' | R --no-save

RUN gem update --no-document --system && gem install --no-document iruby rbczmq pry bio xml-simple gene_ontology 

RUN gem install --no-document rdf
RUN gem install --no-document rdf-raptor
RUN gem install --no-document sparql-client


RUN gem install --no-document ebnf 
RUN gem install --no-document rdf-aggregate-repo
RUN gem install --no-document -f sparql

RUN apt-get install -y ncbi-blast+ ncbi-blast+-legacy blast2 libxml2
RUN apt-get install -y clustalw


USER jovyan
RUN pip install sparqlkernel 
RUN jupyter sparqlkernel install --user
RUN iruby register --force

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
