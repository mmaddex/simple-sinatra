FROM ruby:3.1.2

# RUN git clone https://github.com/mmaddex/simple-sinatra.git
RUN ls
RUN pwd

COPY ./* .
RUN ls
RUN pwd

RUN bundle install

RUN chmod +x /run.sh

EXPOSE 4000
EXPOSE 5000

ENTRYPOINT [ "/run.sh" ]
