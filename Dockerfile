FROM ruby:2.3

ADD Kakomon/Gemfile /tmp
ADD Kakomon/Gemfile.lock /tmp
WORKDIR /tmp
RUN apt-get update && apt-get install -y \
build-essential \
libpq-dev \
nodejs \
vim
RUN rm -rf /var/lib/apt/lists/*
RUN bundle install

ENV RAILS_ENV production
ENV SECRET_KEY_BASE 04b6188af4fa9009afd677f9752e256734a732fd991e185012138b8401b456cb8102ec20207913a3c7f89ed2c92219ceb37a60f1b034e768028e5b51e357641e
RUN mkdir /srv/KAKOMON
ADD Kakomon /srv/KAKOMON/Kakomon
EXPOSE 3000
WORKDIR /srv/KAKOMON/Kakomon
CMD unicorn -E production -c /srv/KAKOMON/Kakomon/deploy/kakomon.ru
