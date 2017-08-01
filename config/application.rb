# encoding: utf-8
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# PostGIS adapter includes a special railtie that provides support for PostGIS databases
# in ActiveRecord’s rake tasks. This railtie is required in order to run, e.g., rake test
require 'active_record/connection_adapters/postgis/railtie'

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

    # Do not suppress errors in `after_rollback`/`after_commit` callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Servir clientes web y API
    config.api_only = false

    config.generators do |g|
      g.test_framework :minitest, spec: true, fixture: false
    end
  end
end
