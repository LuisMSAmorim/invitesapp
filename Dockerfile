FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile* ./

RUN bundle install

ADD . /app

COPY . .

EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0"]
