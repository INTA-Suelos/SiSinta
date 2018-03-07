Rails.application.configure do
  # Enable the asset pipeline
  config.assets.enabled = true

  # Version of your assets, change this if you want to expire all your assets
  config.assets.version = '0.4.7'

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  config.assets.precompile += %w(
    ie.css
    print.css
    fontawesome/fonts/FontAwesome.otf
    fontawesome/fonts/fontawesome-webfont.eot
    fontawesome/fonts/fontawesome-webfont.svg
    fontawesome/fonts/fontawesome-webfont.ttf
    fontawesome/fonts/fontawesome-webfont.woff
    fontawesome/fonts/fontawesome-webfont.woff2
  )
end
