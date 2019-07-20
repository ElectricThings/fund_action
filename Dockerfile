FROM ruby:2.5.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    libtool \
    libsodium-dev \
    imagemagick

RUN mkdir /app
WORKDIR /app

ENV BUNDLE_PATH=/app/vendor/bundle \
    BUNDLE_BIN=/app/vendor/bundle/bin \
    BUNDLE_JOBS=5 \
    BUNDLE_RETRY=3 \
    GEM_HOME=/bundle

ENV PATH="${BUNDLE_BIN}:${PATH}"

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app
