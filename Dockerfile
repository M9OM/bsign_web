FROM ruby:3.2

WORKDIR /app
ARG CACHE_BUST=2

# انسخ كل ملفات مشروعك المعدل
COPY . .

# تثبيت التبعيات
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
 && gem install bundler \
 && bundle install

# تجهيز الأصول (assets)
RUN RAILS_ENV=production bundle exec rake assets:precompile

# تعيين متغيرات البيئة بشكل ديناميكي
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ENV DATABASE_URL=postgresql://$PGUSER:$PGPASSWORD@$PGHOST:$PGPORT/$PGDATABASE

# تشغيل السيرفر
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
