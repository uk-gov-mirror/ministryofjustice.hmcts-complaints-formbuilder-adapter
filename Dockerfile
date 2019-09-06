FROM ruby:2.6.4-alpine3.9

ARG UID

RUN apk add build-base postgresql-contrib postgresql-dev bash tzdata

RUN addgroup -g 1001 -S appgroup && \
  adduser -u 1001 -S appuser -G appgroup

WORKDIR /app
ENV HOME /app

COPY Gemfile* .ruby-version ./

RUN gem install bundler
RUN bundle install

COPY . .

RUN chown -R 1001:appgroup /app

USER 1001

ENV APP_PORT 3000
EXPOSE $APP_PORT

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
CMD bundle exec rake db:migrate && bundle exec rails s -e ${RAILS_ENV} -e ${RAILS_LOG_TO_STDOUT} -p ${APP_PORT} --binding=0.0.0.0
