source 'https://rubygems.org'

gem 'rails', '~> 4.2'

## DB
gem 'pg', '~> 0.15'

## Aut{enticación,orización}, seguridad en general
gem 'devise', '4.4.1'
gem 'cancancan'
gem 'rolify', '~> 3.4'
gem 'rack-cors'
gem 'jwt'

## Presentación
gem 'dynamic_form'
gem 'haml-rails'
gem 'awesome_nested_fields'
gem 'kaminari'
gem 'draper'
gem 'ransack'
gem 'rails-jquery-autocomplete'

## Modelos
gem 'paperclip', '~> 5.2'
gem 'acts-as-taggable-on'
gem 'attribute_normalizer'
gem 'inflections', '0.0.5', require: 'inflections/es'
gem 'active_model_serializers', '~> 0.8.0'
gem 'squeel',
  git: 'https://github.com/activerecord-hackery/squeel.git'

## GIS
gem 'activerecord-postgis-adapter'
gem 'rgeo'
gem 'rgeo-geojson', require: 'rgeo/geo_json'
# Para los datos del IGN
gem 'rubyzip'

## Controladores
gem 'responders'
gem 'has_scope'
# No funciona la inclusión automática, asique la copié a vendor
gem 'browser_detect'
gem 'rails-api'

## Assets
gem 'sprockets', '~> 3.7'
gem 'tinymce-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'therubyracer'
gem 'uglifier'
# FIXME Todavía no hay release compatible con rails4
gem 'multiselectjs_rails',
  git: 'https://github.com/mauriciopasquier/multiselectjs_rails.git'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'select2-rails'
gem 'leaflet-rails'

# Paquetes de bower
source 'https://rails-assets.org' do
  gem 'rails-assets-leaflet.markercluster'
  gem 'rails-assets-leaflet-plugins'
end

# Administración
gem 'activeadmin'

# I18n
gem 'tolk'
gem 'rails-i18n'
gem 'devise-i18n', '1.1.0'
gem 'kaminari-i18n'
# No está publicada la versión compatible con ActiveAdmin 1.0.0
gem 'activeadmin-globalize',
  git: 'https://github.com/mauriciopasquier/activeadmin-globalize.git',
  branch: 'sisar'

## Server
gem 'puma'
# TODO revisar configuración de compresión
gem 'dalli'

## Desarrollo pero útiles en producción
gem 'minitest-rails'
gem 'hirb'

group :test, :development do
  gem 'factory_girl_rails'
  gem 'binding_of_caller'
  gem 'pry-rails'
end

group :development do
  gem 'spring'
  gem 'bullet'
  gem 'better_errors'
  gem 'brakeman', require: false

  # Deploy.
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails-collection', require: false
  gem 'capistrano3-puma', require: false
  # Requeridas por net-ssh?
  # https://github.com/net-ssh/net-ssh/issues/565
  gem 'rbnacl', '< 5.0', require: false
  gem 'bcrypt_pbkdf', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'minitest-rails-capybara'
  gem 'selenium-webdriver'
end
