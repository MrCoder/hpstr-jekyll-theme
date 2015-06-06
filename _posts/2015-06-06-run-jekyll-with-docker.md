---
layout: post
title: "Run Jekyll in Docker on Mac OSX"
description: ""
category:
tags: [jekyll, docker, macosx]
---
## Dockerfile

Jekyll is based on ruby, so we build our image based on the ruby image.
    
    FROM ruby
    MAINTAINER eagle.xiao@gmail.com

Some gems requires a Javascript runtime, so we need to install node and python-pygments is required for syntax highlighting.

    RUN apt-get update
    RUN apt-get install -y node python-pygments

The jekyll gem. Bundler is required if you have your own Gemfile in the folder.

    RUN gem install jekyll bundler

Map a folder from host to /src in the container and expose 4000
    
    VOLUME /src
    EXPOSE 4000

Setup working dir.

    WORKDIR /src

Ideally, we should run bundle install first and then have the ENTRYPOINT to be `ENTRYPOINT ["jekyll"]`. I don't know how to do it that way. (CMD?)
    
    ENTRYPOINT bundle install && jekyll serve -H 0.0.0.0

## Build the docker image
Change directory into where the Dockerfile is stored. Do not miss the "." a the end.
    
    docker build -t mrcoder/jekyll .

## Clone theme
I use a theme forked from [here](https://github.com/mmistakes/hpstr-jekyll-theme). Simply clone it locally:

    git clone https://github.com/mmistakes/hpstr-jekyll-theme.git

## Run the Docker image

    docker run --rm -v "$PWD:/src" -p 4000:4000 mrcoder/jekyll

If you are running it with boot2docker, you need to find out the ip of the docker host with `boot2docker ip` and open the site with `http://ip-of-the-host:4000`.


