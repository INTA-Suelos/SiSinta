source 'http://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

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
gem 'rgeo-geojson', :require => 'rgeo/geo_json'

# Esta gema falla a partir de algún cambio de ActiveRecord
#gem 'postgis_adapter'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'therubyracer', '= 0.10.1' # la 0.11 no me compila
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'
gem 'thin'
gem 'sysloglogger'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'pry'
  gem 'pry-rails'
  gem 'hirb'
  gem 'bullet'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest'
  gem 'factory_girl_rails'
end
