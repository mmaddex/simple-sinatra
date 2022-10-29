FROM ruby:2.7.2

# RUN git clone https://github.com/mmaddex/simple-sinatra.git
RUN ls
RUN pwd

WORKDIR /sinat
RUN ls
RUN pwd
COPY sinat ./src
RUN ls
RUN pwd
COPY run.sh .

RUN bundle install

# RUN chmod +x /run.sh

EXPOSE 4000
EXPOSE 5000

ENTRYPOINT [ "/run.sh" ]
