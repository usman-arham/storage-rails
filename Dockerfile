FROM ruby:3.1.0

WORKDIR /usr/src/app

COPY . .
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]
RUN bundle install