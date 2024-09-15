FROM ruby:3.1

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

ENTRYPOINT ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
