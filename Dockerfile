FROM perseidsproject/morpheus:v1.0.0

RUN apt-get update -qq && apt-get install -qq -y ruby ruby-dev

ADD . /app
WORKDIR /app

ENV RACK_ENV=production
ENV BUNDLE_SILENCE_ROOT_WARNING 1

RUN gem install bundler --version 2.1.4
RUN bundle install

CMD bundle exec ruby app.rb
