source 'http://rubygems.org'

gem 'rails', '3.2.18'

## DB
gem 'pg'
gem 'yaml_db'

## Aut{enticación,orización}, seguridad en general
gem 'devise'
gem 'devise-i18n'
gem 'cancancan'
gem 'rolify', '~> 3.2.0'
gem 'strong_parameters'

## Presentación
gem 'dynamic_form'
gem 'haml-rails'
gem 'awesome_nested_fields'
gem 'kaminari'
gem 'draper'
gem 'ransack'
gem 'rails3-jquery-autocomplete',
  git: 'https://github.com/mauriciopasquier/rails3-jquery-autocomplete.git'

## Modelos
gem 'paperclip'
gem 'active_hash'
gem 'acts-as-taggable-on'
gem 'attribute_normalizer'
gem 'inflections', '0.0.5', require: 'inflections/es'
gem 'active_model_serializers'

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
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'therubyracer'
  gem 'uglifier'
  # FIXME No hay release compatible con rails4
  gem 'multiselectjs_rails', git: 'https://github.com/mauriciopasquier/multiselectjs_rails.git'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'select2-rails'
end

## Server
gem 'thin'
gem 'libmemcached_store'

## Desarrollo
gem 'minitest-rails'
gem 'version'
gem 'awesome_print'

group :test, :development do
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'bullet'
  gem 'capistrano', '< 3'
  gem 'capistrano-rbenv'
end

group :test do
  gem 'turn'
  gem 'factory_girl_rails'
  gem 'capybara', '~> 2.0.3'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'minitest-rails-capybara'
end
