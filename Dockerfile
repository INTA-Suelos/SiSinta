FROM ruby:2.5.9-stretch

# Reemplazar las sources.list obsoletas con las de archive.debian.org,
# actualizar e instalar dependencias.
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.debian.org/debian/ stretch contrib main non-free" > /etc/apt/sources.list
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      shared-mime-info \
      libpq-dev \
      libsodium-dev \
      nodejs

RUN useradd --user-group --system --create-home -G sudo app
USER app:app
WORKDIR /home/app/sisinta

# Instalar gemas.
COPY --chown=app:app Gemfile Gemfile.lock .
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN gem install bundler:1.17.3
RUN bundle config set without 'development test'
RUN bundle install

COPY --chown=app:app . .

EXPOSE 3000
CMD ["bin/start"]
