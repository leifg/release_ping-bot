FROM ruby:2.4-alpine3.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk add --no-cache --virtual .gem-builddeps \
      build-base \
    && bundle install \
    && apk del .gem-builddeps

COPY . /usr/src/app

ENTRYPOINT [ "/usr/local/bin/ruby", "/usr/src/app/tweet.rb" ]
