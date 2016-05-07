# No hardcodear el Middleware de referencia por si cambia.
Rails.application.config.middleware.insert_after 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :options]
  end
end
