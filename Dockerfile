FROM andrewosh/binder-base

MAINTAINER markw@illuminae.com

USER root

# Add IRuby dependencies
RUN apt-get update
RUN apt-get install -y build-essential ruby ruby-dev libzmq3 libzmq3-dev libtool autoconf automake && apt-get clean
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385
RUN apt-get install ncbi-blast+ ncbi-blast+-legacy libxml2

RUN gem update --no-document --system && gem install --no-document iruby rbczmq pry bio nokogiri rdf 

USER main

RUN iruby register
