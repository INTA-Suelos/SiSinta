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

# Configurar el usuario "app".
RUN useradd --user-group --system --create-home -G sudo app
USER app:app
WORKDIR /home/app/

# Instalar gemas.
COPY --chown=app:app Gemfile Gemfile.lock .
# Ignorar documentación.
# Ignorar entornos no de producción.
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc && \
    gem install bundler:1.17.3 && \
    bundle config set without 'development test' && \
    bundle install

# Copiar todo el build context a la imagen.
COPY --chown=app:app . .

# Precompilar assets.
ARG RAILS_ENV SECRET_KEY_BASE MEMCACHE_SERVERS
ENV RAILS_ENV=$RAILS_ENV SECRET_KEY_BASE=$SECRET_KEY_BASE MEMCACHE_SERVERS=$MEMCACHE_SERVERS
RUN bundle exec rake assets:precompile

# Exponer este directorio para que sea accesible desde afuera (e.g. desde nginx).
USER root
# Copiamos a un volumen que pueda acceder nginx. Si movemos en vez de copiar,
# sprockets deja de usar el manifest.
RUN mkdir -p /usr/share/nginx && \
    cp -r public /usr/share/nginx/html && \
    chown -R root:root /usr/share/nginx/html
# Define un "anonymous volume" con este mountpoint.
VOLUME /usr/share/nginx/html

CMD ["bin/start"]
