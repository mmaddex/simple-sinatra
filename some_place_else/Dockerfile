FROM ruby:3.1.2
WORKDIR /code
COPY . /code
RUN bundle install

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
