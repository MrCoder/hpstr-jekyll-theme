FROM ruby
MAINTAINER eagle.xiao@gmail.com

RUN apt-get update
RUN apt-get install -y node python-pygments

RUN gem install jekyll bundler

VOLUME /src
EXPOSE 4000

WORKDIR /src

ENTRYPOINT bundle install && jekyll serve -H 0.0.0.0
