FROM andrewosh/binder-base

MAINTAINER markw@illuminae.com

USER root

RUN apt-get update
RUN apt-get install -y build-essential ruby ruby-dev libzmq3 libzmq3-dev libtool autoconf automake && apt-get clean
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385


# Add IRuby dependencies

RUN gem update --no-document --system && gem install --no-document iruby rbczmq pry bio xml-simple gene_ontology 
RUN gem install --no-document rdf -v 2.0.2
RUN gem install --no-document rdf-raptor -v 2.0.0 
RUN gem install --no-document sparql-client -v 2.0.2

RUN apt-get install -y ncbi-blast+ ncbi-blast+-legacy blast2 libxml2
RUN apt-get install -y clustalw

USER main
RUN pip install sparqlkernel 
RUN jupyter sparqlkernel install --user
RUN iruby register
