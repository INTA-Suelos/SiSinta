# encoding: utf-8
SiSINTA::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true

  # Habilito el cache para pruebas
  config.action_controller.perform_caching = true
  config.cache_store = :libmemcached_store

  # Para testear Devise
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default charset: "utf-8"

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Cómo guardar los archivos adjuntos. Usa la interpolación de Paperclip y el
  # símbolo :url que está definido en el modelo Adjunto
  config.adjunto_path = '/var/tmp/sisinta-dev:url'

  # Bullet
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
  end

  # Configuración de ejemplo para riseup.net
  ActionMailer::Base.smtp_settings = {
    address: 'mail.riseup.net',

    # usar TLS
    enable_starttls_auto: true,

    # puerto para TLS
    port:                 587,

    # dominio desde el que enviamos
    domain:               'dominio.com.ar',

    user_name:            'nombre de usuario',
    password:             'password',

    # envía en texto plano pero envuelto en TLS
    authentication:       :plain
  }

end
