
FROM dockerfile/ubuntu

###Dependencies
RUN sudo apt-get install -y curl sqlite3 libsqlite3-dev git
RUN apt-get install -y ruby ruby-dev ruby-bundler
RUN apt-get install -y libmysqlclient-dev freetds-dev

RUN curl -L -0 https://pfgray.github.io/casa-bootstrap/local | bash -s - -db sqlite

WORKDIR /root/casa
RUN git clone https://github.com/IMSGlobal/casa-admin-outlet

RUN  sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get update && sudo apt-get install -y python-software-properties python g++ make nodejs



WORKDIR /root/casa/casa-admin-outlet

RUN npm install
RUN npm install bower -g
RUN bower install --allow-root

RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

###Configuration
WORKDIR /root/casa
ADD ./environment-config.json /root/casa/casa-environment/config/dev.json
ADD ./admin-outlet-config.js /root/casa/casa-admin-outlet/src/config/engine.js

WORKDIR /root/casa/casa-environment
RUN bundle exec casa-environment configure


WORKDIR /root/casa/casa-admin-outlet
RUN bundle install
RUN bundle exec blocks build

WORKDIR /root/casa

ADD ./app.sh /root/casa/app.sh

RUN sudo chmod 755 /root/casa/app.sh

EXPOSE 3000
EXPOSE 5000

CMD ["./app.sh"]
