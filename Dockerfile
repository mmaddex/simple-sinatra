FROM ruby:3.1.2

#ARG SECRET_SECRET
#ARG DASHBOARD_DEFINED
#RUN echo $DASHBOARD_DEFINED

#ARG GROUP_ENV_PLAIN
#RUN echo $GROUP_ENV_PLAIN

#ARG RAILS_ENV
#RUN echo $RAILS_ENV
ADD cron ./
RUN echo "lsing"
RUN ls ./
ADD config.ru /etc/
RUN cat /etc/config.ru
COPY ./* .
RUN chmod +x /loads_secrets.sh

# broken RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.json cat /etc/secrets/secret.json
#RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.json cat secret.json
# secrets are available in loads_secrets.sh
#RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.json ./loads_secrets.sh
#RUN echo "out the secrets loader"
# note that these don't show up
#RUN echo $SECRET_SECRET
#RUN echo $SECOND_SECRET

#RUN gem update --system
#RUN chmod +x /build.sh
#RUN /build.sh
RUN bundle install
COPY ./* .

RUN chmod +x /run.sh

#ENV PORT=5555

#EXPOSE 5555

#ENTRYPOINT [ "/run.sh" ]
CMD [ "/run.sh" ]
#CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
