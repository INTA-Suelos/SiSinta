Rails.application.configure do
  # Enable the asset pipeline
  config.assets.enabled = true

  # Version of your assets, change this if you want to expire all your assets
  config.assets.version = '0.4.6'

  # Traduzco el path
  config.assets.prefix = '/estaticos'

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  config.assets.precompile += %w( ie.css print.css )
end
