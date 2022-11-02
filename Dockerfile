FROM ruby:3.1.2

RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file cat /etc/secrets/secret.file
RUN --mount=type=secret,id=secret_file,dst=/etc/secrets/secret.file . /etc/secrets/secret.file

RUN ls
RUN pwd

COPY ./* ./app
RUN ls
RUN cd app
RUN pwd
RUN ls

RUN bundle install

RUN chmod +x /run.sh

EXPOSE 4000

ENTRYPOINT [ "/run.sh" ]
