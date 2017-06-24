Rails.application.configure do
  # Buscar locales en subdirectorios de /config/locales
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

  # Whitelistear los locales soportados
  config.i18n.available_locales = [:es, :en]
  config.i18n.enforce_available_locales = true

  # Usar español por default
  config.i18n.default_locale = :es

  # Usar español como fallback
  config.i18n.fallbacks = { en: :es }
end
