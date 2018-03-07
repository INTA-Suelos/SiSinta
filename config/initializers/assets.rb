Rails.application.configure do
  # Precompile additional assets.
  config.assets.precompile += %w( print.css )

  # Enable the asset pipeline
  config.assets.enabled = true

  # Version of your assets, change this if you want to expire all your assets
  config.assets.version = '0.4.7'
end
