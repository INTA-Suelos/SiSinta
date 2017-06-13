# Buscar locales en subdirectorios de /config/locales
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

# Whitelistear los locales soportados
I18n.available_locales = [:es, :en]
I18n.enforce_available_locales = true

# Usar español por default
I18n.default_locale = :es
