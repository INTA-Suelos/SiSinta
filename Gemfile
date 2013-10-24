source 'http://rubygems.org'

gem 'rails', '3.2.14'

## DB
gem 'pg'
gem 'yaml_db'

## Aut{enticación,orización}, seguridad en general
gem 'devise'
gem 'devise-i18n'
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
gem 'rails3-jquery-autocomplete',
  git: 'https://github.com/mauriciopasquier/rails3-jquery-autocomplete.git',
  branch: 'scopes-with-parameters'

## Modelos
gem 'paperclip'
gem 'active_hash'
gem 'rocket_tag', git: 'https://github.com/bradphelan/rocket_tag.git'
gem 'attribute_normalizer'
gem 'inflections'
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
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'therubyracer'
  gem 'uglifier'
  gem 'tinymce-rails'
  gem 'multiselectjs_rails'
  gem 'jquery-rails'
  gem 'select2-rails'
end

## Server
gem 'thin'
gem 'rails3_libmemcached_store'

## Desarrollo
gem 'minitest-rails'
gem 'version'

group :test, :development do
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rbenv'
end

group :test do
  gem 'turn'
  gem 'factory_girl_rails'
  gem 'capybara', '~> 2.0.3'
  gem 'capybara-webkit'
  gem 'capybara_minitest_spec'
  gem 'database_cleaner'
end
