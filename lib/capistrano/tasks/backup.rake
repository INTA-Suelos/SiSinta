# encoding: utf-8
# Hace un backup de la base de datos con yaml_db antes de actualizar
#
# TODO tarea para pasar esos backups al servidor de backups (o localmente)
namespace :backup do
  desc 'Asegura un directorio donde acumular los backups'
  task :checkear do
    on roles(:app) do
      execute :mkdir, '-pv', fetch(:backup_path)
    end
  end

  # Depende de yaml_db y de que el entorno de rails esté configurado
  desc 'Genera un backup en .yml'
  task :remoto => [:checkear, 'deploy:set_rails_env'] do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:data:dump_dir'
        end
      end
    end
  end

  desc 'Acumula los backups fuera del release'
  task :acumular => :remoto do
    on roles(:app) do
      within release_path do
        # FIXME deshardcodear el path de los backups generados (bug Y2.1K)
        execute :mv, 'db/20*', fetch(:backup_path)
      end
    end
  end

  before 'deploy:updated', 'backup:acumular'
end

namespace :load do
  task :defaults do
    set :backup_path, -> { shared_path.join('backup') }
  end
end
