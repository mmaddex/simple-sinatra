FROM ruby:3.1.2

ARG SECRET_SECRET

COPY ./* .
RUN chmod +x /loads_secrets.sh

RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file cat /etc/secrets/secret.file
#RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file . /etc/secrets/secret.file
RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file ./loads_secrets.sh
RUN echo "out the secrets loader"
RUN echo $SECRET_SECRET
RUN echo $SECOND_SECRET


RUN pwd
RUN ls

RUN bundle install

RUN chmod +x /run.sh

EXPOSE 4000

ENTRYPOINT [ "/run.sh" ]
