FROM ruby:2.7-alpine

WORKDIR /usr/src/app

COPY .github/build.sh /usr/src/bin/

RUN gem install bundler

RUN apk --no-cache --update add nodejs g++ make coreutils git zip && \
    git clone https://github.com/slatedocs/slate.git /usr/src/app && \
    bundle install && \
    chmod +x /usr/src/bin/*.sh

## Remove the original source of slatedocs with our WIAPI docs
RUN rm -rf /usr/src/app/source
COPY source/ /usr/src/app/source/

CMD ["sh", "/usr/src/bin/build.sh"]
