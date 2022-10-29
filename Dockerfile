FROM ruby:2.7.2

RUN git clone https://github.com/mmaddex/simple-sinatra.git

RUN bundle install

COPY run.sh ./
# RUN chmod +x /run.sh

EXPOSE 4000
EXPOSE 5000

ENTRYPOINT [ "/run.sh" ]
