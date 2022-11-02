FROM ruby:3.1.2

ARG SECRET_SECRET
ARG DASHBOARD_DEFINED
RUN echo $DASHBOARD_DEFINED

ADD config.ru /etc/sin/
RUN cat /etc/sin/config.ru
COPY ./* .
RUN chmod +x /loads_secrets.sh

RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file cat /etc/secrets/secret.file
# secrets are available in loads_secrets.sh
RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file ./loads_secrets.sh
RUN echo "out the secrets loader"
# note that these don't show up
RUN echo $SECRET_SECRET
RUN echo $SECOND_SECRET

RUN bundle install

RUN chmod +x /run.sh

EXPOSE 4000

ENTRYPOINT [ "/run.sh" ]
