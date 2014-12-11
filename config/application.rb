# encoding: utf-8
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# PostGIS adapter includes a special railtie that provides support for PostGIS databases
# in ActiveRecord’s rake tasks. This railtie is required in order to run, e.g., rake test
require 'active_record/connection_adapters/postgis_adapter/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SiSINTA
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += ["#{config.root}/lib/extensiones/",
                              "#{config.root}/lib/helpers/" ]

    config.action_controller.include_all_helpers = false

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '0.3.8'

    # Traduzco el path
    config.assets.prefix = '/estaticos'

    # Manejo de versiones en la aplicación
    is_versioned
  end
end
