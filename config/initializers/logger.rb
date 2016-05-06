# Extensión del logger para que las tareas de Rake larguen sus logs a la
# consola. Va acá porque `config/environments/development.rb` carga antes que
# la definición del logger, y queremos reutilizar el default
if Rails.env.development? && defined?(Rake) && Rake.application.top_level_tasks.any?
  consola = ActiveSupport::Logger.new(STDOUT)
  Rails.logger.extend ActiveSupport::Logger.broadcast(consola)
end
