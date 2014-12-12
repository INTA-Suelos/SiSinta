source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.0.12'

## DB
gem 'pg'
# Rama con un parche para que las join tables salgan ordenadas
gem 'yaml_db', git: 'https://github.com/mauriciopasquier/yaml_db.git', branch: 'order-join-tables'

## Aut{enticación,orización}, seguridad en general
gem 'devise'
gem 'devise-i18n'
gem 'cancancan'
gem 'rolify', '~> 3.4'

## Presentación
gem 'dynamic_form'
gem 'haml-rails'
gem 'awesome_nested_fields'
gem 'kaminari'
gem 'draper'
gem 'ransack'
gem 'rails3-jquery-autocomplete'

## Modelos
gem 'paperclip'
gem 'active_hash'
gem 'acts-as-taggable-on'
gem 'attribute_normalizer'
gem 'inflections', '0.0.5', require: 'inflections/es'
gem 'active_model_serializers', '~> 0.8.0'
gem 'squeel', git: 'https://github.com/activerecord-hackery/squeel.git'

## GIS
gem 'activerecord-postgis-adapter'
gem 'rgeo'
gem 'rgeo-geojson', require: 'rgeo/geo_json'

## Controladores
gem 'responders'
gem 'has_scope'
# No funciona la inclusión automática, asique la copié a vendor
gem 'browser_detect'

## Assets
gem 'tinymce-rails'
# FIXME descongelar versión con rails 4.1.x (https://github.com/rails/sass-rails/issues/191#issuecomment-39155285)
gem 'sass-rails', '4.0.2'
gem 'coffee-rails'
gem 'therubyracer'
gem 'uglifier'
# FIXME Todavía no hay release compatible con rails4
gem 'multiselectjs_rails', git: 'https://github.com/mauriciopasquier/multiselectjs_rails.git'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'select2-rails'
gem 'leaflet-rails'
gem 'rails-assets-leaflet.markercluster'

## Server
gem 'thin'
# TODO revisar configuración de compresión
gem 'dalli'

## Desarrollo
gem 'minitest-rails'
gem 'version'
gem 'awesome_print'

group :test, :development do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end

group :test do
  gem 'database_cleaner'
  gem 'minitest-rails-capybara'
  gem 'selenium-webdriver'
end
