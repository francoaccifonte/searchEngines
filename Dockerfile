FROM ruby:3.1.0-alpine as builder

ARG bundler_ignored_groups="development test"

RUN apk add --update --no-cache bash build-base libcurl tzdata shared-mime-info postgresql-client postgresql-dev \
                                imagemagick ttf-liberation curl

RUN mkdir $HOME/app
WORKDIR /home/app

COPY . .
RUN bundle config set without $bundler_ignored_groups
RUN bundle install

