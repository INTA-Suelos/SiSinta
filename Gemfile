source 'http://rubygems.org'

gem 'rails', '3.2.9'

## DB
gem 'pg'
gem 'yaml_db'

## Aut{enticación,orización}, seguridad en general
gem 'devise'
gem 'cancan'
gem 'param_protected'
gem 'rolify'

## Presentación
gem 'dynamic_form'
gem 'haml-rails'
gem 'awesome_nested_fields'
gem 'kaminari'
gem 'draper'
gem 'ransack'
gem 'jquery-rails'
gem 'tinymce-rails'
gem 'multiselectjs_rails'

# No funciona la inclusión automática, asique la copié a vendor
gem 'browser_detect'

## Modelos
gem 'paperclip'
gem 'active_hash'
gem 'rocket_tag'
gem 'attribute_normalizer'

## GIS
gem 'activerecord-postgis-adapter'
gem 'rgeo'
gem 'rgeo-geojson', require: 'rgeo/geo_json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'therubyracer', '= 0.10.1' # la 0.11 no me compila
  gem 'uglifier'
end

gem 'thin'
gem 'SyslogLogger', require: 'syslog/logger'

group :development do
  gem 'pry'
  gem 'pry-rails'
  gem 'hirb'
  gem 'bullet'
end

group :test do
  # Pretty printed test output
  gem 'turn'
  gem 'minitest'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
end
