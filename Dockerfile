FROM jupyter/datascience-notebook:1fbaef522f17
MAINTAINER markw@illuminae.com
USER root

RUN apt-get update
RUN apt-get install -y aptitude
RUN apt-get update

RUN apt-get install -y libcurl4-openssl-dev libssl-dev 
RUN apt-get install -y software-properties-common gnupg2

RUN command curl -sSL https://rvm.io/mpapis.asc | gpg --import -

#RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.4.0


RUN apt-get install -y ruby ruby-dev libffi-dev libtool autoconf automake libcurl4-gnutls-dev libraptor2-dev && apt-get clean
RUN apt-get install -y libzmq3-dev libczmq-dev
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385
RUN apt-get autoremove -y


RUN echo 'install.packages(c("repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest", "dplyr","ggplot2","gapminder"),repos="http://cran.r-project.org" )' | R --no-save
RUN echo 'install.packages(c("uuid", "digest","gapminder"),repos="http://cran.r-project.org" )' | R --no-save

RUN gem update --no-document --system && gem install --no-document cztop iruby rbczmq pry bio xml-simple gene_ontology  nokogiri equivalent-xml

RUN gem install --no-document rdf
RUN gem install --no-document rdf-raptor
RUN gem install --no-document sparql-client


RUN gem install --no-document ebnf 
RUN gem install --no-document rdf-aggregate-repo
RUN gem install --no-document -f sparql

RUN apt-get install -y ncbi-blast+ ncbi-blast+-legacy blast2 libxml2
RUN apt-get install -y clustalw

RUN iruby register --force RUN jupyter kernelspec install ~/.ipython/kernels/ruby

RUN pip install sparqlkernel 
RUN jupyter sparqlkernel install --user


USER jovyan

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
