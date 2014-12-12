# encoding: utf-8
# Recetas de Capistrano para configurar la aplicación
#
# Agregá cada archivo de configuración en :linked_files, por ejemplo:
#
#     set :linked_files, %w{config/database.yml config/secrets.yml}
#
namespace :config do
  desc 'Garantiza que haya un directorio para la configuración'
  task :preparar do
    on roles(:app) do
      execute :mkdir, '-pv', fetch(:config_path)
    end
  end

  desc 'Configura la aplicación con los valores para producción'
  task :configurar => :preparar do
    # Prepara según la tarea que definamos, por default es config:subir
    invoke fetch(:config_source)
  end

  desc 'Sube al server la configuración desde config=path (:config_local_path por default)'
  task :subir => [:preparar, fetch(:config_local_path)] do
    dir = ENV['config'] || fetch(:config_local_path)

    on roles(:app) do
      Dir.glob("#{dir}/*").each do |archivo|
        upload! archivo, fetch(:config_path), recursive: true
      end
    end
  end

  # Antes del checkeo así podemos usar linked_files
  before 'deploy:check', 'config:configurar'
end

# Avisa de dónde se saca la configuración del stage
# TODO revisar si se puede usar la variable de capistrano en este file para evitar el mensaje
file fetch(:config_local_path) do
  unless ENV['config'] || fetch(:config_local_path)
    puts <<-AVISO

      Si #{fetch(:config_local_path)} no existe se usa la configuración que ya está en el
      servidor. Si querés subir cambios creá/linkeá el directorio o pasá
      config=otro_dir como parámetro.

    AVISO
  end
end

# Capistrano carga los defaults con esta tarea
namespace :load do
  task :defaults do
    # Guardamos la configuración en shared/config
    set :config_path, -> { shared_path.join('config') }
    # Sacamos la configuración del tmp de rails de acuerdo al stage (e.g.
    # tmp/production-config)
    set :config_local_path, "tmp/#{fetch(:stage)}-config"
    # Tarea que saca la configuración de algún lado
    set :config_source, 'config:subir'
  end
end
