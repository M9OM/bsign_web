### Stage 1: Download fonts and pdfium
FROM ruby:3.4.2-alpine AS download

WORKDIR /fonts

RUN apk --no-cache add fontforge wget && \
    wget https://github.com/satbyy/go-noto-universal/releases/download/v7.0/GoNotoKurrent-Regular.ttf && \
    wget https://github.com/satbyy/go-noto-universal/releases/download/v7.0/GoNotoKurrent-Bold.ttf && \
    wget https://github.com/impallari/DancingScript/raw/master/fonts/DancingScript-Regular.otf && \
    wget https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSymbols2/hinted/ttf/NotoSansSymbols2-Regular.ttf && \
    wget https://github.com/Maxattax97/gnu-freefont/raw/master/ttf/FreeSans.ttf && \
    wget https://github.com/impallari/DancingScript/raw/master/OFL.txt && \
    wget -O pdfium-linux.tgz "https://github.com/docusealco/pdfium-binaries/releases/latest/download/pdfium-linux-$(uname -m | sed 's/x86_64/x64/;s/aarch64/arm64/').tgz" && \
    mkdir -p /pdfium-linux && \
    tar -xzf pdfium-linux.tgz -C /pdfium-linux

RUN fontforge -lang=py -c 'font1 = fontforge.open("FreeSans.ttf"); font2 = fontforge.open("NotoSansSymbols2-Regular.ttf"); font1.mergeFonts(font2); font1.generate("FreeSans.ttf")'


### Stage 2: Webpack / Assets compilation
FROM ruby:3.4.2-alpine AS webpack

ENV RAILS_ENV=production
ENV NODE_ENV=production

WORKDIR /app

RUN apk add --no-cache nodejs yarn git build-base && \
    gem install shakapacker

COPY . .

RUN yarn install --network-timeout 1000000 && \
    ./bin/shakapacker


### Stage 3: Final app
FROM ruby:3.4.2-alpine AS app

ENV RAILS_ENV=production
ENV BUNDLE_WITHOUT="development:test"
ENV LD_PRELOAD=/lib/libgcompat.so.0
ENV OPENSSL_CONF=/app/openssl_legacy.cnf

WORKDIR /app

# Add edge repo for some packages
RUN echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk add --no-cache \
    sqlite-dev libpq-dev mariadb-dev \
    vips-dev@edge redis \
    libheif@edge vips-heif@edge gcompat ttf-freefont build-base && \
    mkdir -p /fonts && \
    rm -f /usr/share/fonts/freefont/FreeSans.otf

# Enable OpenSSL legacy provider
RUN echo $'.include = /etc/ssl/openssl.cnf\n\
\n\
[provider_sect]\n\
default = default_sect\n\
legacy = legacy_sect\n\
\n\
[default_sect]\n\
activate = 1\n\
\n\
[legacy_sect]\n\
activate = 1' > /app/openssl_legacy.cnf

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    apk del build-base && \
    rm -rf ~/.bundle /usr/local/bundle/cache && \
    ruby -e "puts Dir['/usr/local/bundle/**/{spec,rdoc,resources/shared,resources/collation,resources/locales}']" | xargs rm -rf

COPY . .

# Copy fonts and pdfium from download stage
COPY --from=download /fonts/*.ttf /fonts/
COPY --from=download /fonts/OFL.txt /fonts/
COPY --from=download /fonts/FreeSans.ttf /usr/share/fonts/freefont/
COPY --from=download /pdfium-linux/lib/libpdfium.so /usr/lib/libpdfium.so
COPY --from=download /pdfium-linux/licenses/pdfium.txt /usr/lib/libpdfium-LICENSE.txt

# Copy compiled packs
COPY --from=webpack /app/public/packs ./public/packs

RUN ln -s /fonts /app/public/fonts
RUN bundle exec bootsnap precompile --gemfile app/ lib/

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
