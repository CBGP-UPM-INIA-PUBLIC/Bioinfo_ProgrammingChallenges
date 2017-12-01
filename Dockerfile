FROM andrewosh/binder-base

MAINTAINER markw@illuminae.com

USER root

# Add IRuby dependencies
RUN  apt-get install -y apt-utils
RUN apt-get update
RUN  apt-get install -y software-properties-common python-software-properties

RUN add-apt-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y build-essential ruby2.2 ruby2.2-dev libzmq3 libzmq3-dev libtool autoconf automake && apt-get clean
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool # See https://github.com/zeromq/libzmq/issues/1385
RUN apt-get install -y ncbi-blast+ ncbi-blast+-legacy libxml2
RUN sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.2 400  --slave /usr/bin/rake rake /usr/bin/rake2.2  --slave /usr/bin/ri ri /usr/bin/ri2.2  --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.2  --slave /usr/bin/gem gem /usr/bin/gem2.2  --slave /usr/bin/irb irb /usr/bin/irb2.2  --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby2.2.1.gz  --slave /usr/share/man/man1/rake.1.gz rake.1.gz /usr/share/man/man1/rake2.2.1.gz  --slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri2.2.1.gz  --slave /usr/share/man/man1/rdoc.1.gz rdoc.1.gz /usr/share/man/man1/rdoc2.2.1.gz  --slave /usr/share/man/man1/gem.1.gz gem.1.gz /usr/share/man/man1/gem2.2.1.gz  --slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb2.2.1.gz

RUN gem update --no-document --system && gem install --no-document iruby rbczmq pry bio nokogiri rdf 

USER main

RUN iruby register
