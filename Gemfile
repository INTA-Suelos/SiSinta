source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

## DB
gem 'pg'

## Aut{enticación,orización}, seguridad en general
gem 'devise'
gem 'cancan'
gem 'param_protected'

## Presentación
gem 'dynamic_form'
gem 'haml-rails'
gem 'awesome_nested_fields'
gem 'kaminari'
gem 'draper'

# No funciona la inclusión automática, asique la copié a vendor
gem 'browser_detect'

## Modelos
gem 'paperclip'
gem 'active_hash'
gem 'rocket_tag'

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
  gem 'therubyracer'
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'
gem 'thin'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'pry'
  gem 'pry-rails'
  gem 'hirb'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest'
end
