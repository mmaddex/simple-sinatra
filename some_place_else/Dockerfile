FROM ruby:3.1.2

#ARG SECRET_SECRET
#ARG DASHBOARD_DEFINED
#RUN echo $DASHBOARD_DEFINED

#ARG GROUP_ENV_PLAIN
#RUN echo $GROUP_ENV_PLAIN

#ARG RAILS_ENV
#RUN echo $RAILS_ENV

ADD config.ru /etc/
RUN cat /etc/config.ru

WORKDIR /code
COPY . /code
RUN bundle install

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
