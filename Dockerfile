FROM ruby:2.6.4-alpine3.9

RUN apk add build-base postgresql-contrib postgresql-dev bash tzdata

ARG UID='1001'
RUN addgroup -S appgroup && \
  adduser -u ${UID} -S appuser -G appgroup


WORKDIR /app
ENV HOME /app

RUN chown appuser:appgroup /app

COPY --chown=appuser:appgroup Gemfile Gemfile.lock .ruby-version ./

RUN gem install bundler

ARG BUNDLE_FLAGS="--jobs 2 --no-cache --without development test"
RUN bundle install ${BUNDLE_FLAGS}

COPY --chown=appuser:appgroup . .

ENV APP_PORT 3000
EXPOSE $APP_PORT

ARG RAILS_ENV='production'
ENV RAILS_ENV=$RAILS_ENV

USER ${UID}

CMD bundle exec rake db:migrate && bundle exec rails s -p ${APP_PORT} --binding=0.0.0.0
