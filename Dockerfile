
FROM dockerfile/ubuntu

RUN sudo apt-get install -y curl sqlite3 libsqlite3-dev git

RUN apt-get install -y ruby ruby-dev ruby-bundler

RUN apt-get install -y libmysqlclient-dev freetds-dev

RUN curl -L -0 https://pfgray.github.io/casa-bootstrap/local | bash -s - -db sqlite

WORKDIR /root/casa/casa-environment

RUN sed -i 's/mysql2/sqlite/g' config/dev.json

RUN bundle exec casa-environment configure

WORKDIR /root/casa/casa-engine

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "-p", "3000"]

