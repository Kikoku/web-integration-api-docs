FROM ruby:2.7-alpine

COPY build-local-doc.sh /usr/bin/

RUN apk --no-cache --update add nodejs g++ make coreutils git && \
    git clone https://github.com/slatedocs/slate.git /slate && cd slate \
    && echo 'gem "middleman-livereload", "~> 3.4.3"' >> Gemfile \
    && echo 'activate :livereload' >> config.rb \
    && bundle install \
    && chmod +x /usr/bin/*.sh

WORKDIR /slate

EXPOSE 4567

ENTRYPOINT ["sh", "/usr/bin/build-local-doc.sh"]
