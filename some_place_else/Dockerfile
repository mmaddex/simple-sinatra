FROM ruby:3.1.2

#ARG SECRET_SECRET
#ARG DASHBOARD_DEFINED
#RUN echo $DASHBOARD_DEFINED

#ARG GROUP_ENV_PLAIN
#RUN echo $GROUP_ENV_PLAIN
ARG RENDER_INSTANCE_ID
#ARG RAILS_ENV
#RUN echo $RAILS_ENV
RUN ls ./
RUN echo $RENDER_PROJECT_CACHE_DIRS
RUN echo $RENDER_INSTANCE_ID
ADD config.ru /etc/
RUN cat /etc/config.ru

WORKDIR /code
#COPY . /code
COPY . ./
RUN bundle install
RUN ls ./

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
