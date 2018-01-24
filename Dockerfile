FROM andrewosh/binder-base

MAINTAINER markw@illuminae.com

USER root

RUN apt-get update

RUN apt-get install -y aptitude

RUN echo 'deb http://deb.debian.org/debian jessie-backports main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb http://deb.debian.org/debian jessie-backports-sloppy main contrib non-free' >> /etc/apt/sources.list

RUN aptitude update
RUN apt-get install -y -t jessie-backports r-base r-base-dev


RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev libssl-dev 
RUN apt-get install -y software-properties-common

RUN apt-get install -y build-essential ruby ruby-dev libcurl4-openssl-dev libssl-dev libzmq3 libzmq3-dev libtool autoconf automake && apt-get clean
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385



# RUN echo 'install.packages(c("repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest", "dplyr","ggplot2","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'install.packages(c("devtools", "uuid", "digest", "dplyr","ggplot2","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'devtools::install_github("IRkernel/IRkernel")' | R --no-save
RUN echo 'IRkernel::installspec()' | R --no-save
# Add IRuby dependencies

RUN gem update --no-document --system && gem install --no-document iruby rbczmq pry bio xml-simple gene_ontology 
RUN gem install --no-document rdf-aggregate-repo -v 2.0.0
RUN gem install --no-document rdf -v 2.0.2
RUN gem install --no-document rdf-raptor -v 2.0.0 
RUN gem install --no-document sparql-client -v 2.0.2

RUN gem install --no-document sparql -v 2.0.0.beta1

RUN apt-get install -y ncbi-blast+ ncbi-blast+-legacy blast2 libxml2
RUN apt-get install -y clustalw

USER main
RUN pip install sparqlkernel 
RUN jupyter sparqlkernel install --user
RUN iruby register

COPY . /home/main
