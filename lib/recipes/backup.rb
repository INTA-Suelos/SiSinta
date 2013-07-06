# encoding: utf-8
# Recetas para Capistrano relacionadas con los backups
# Opciones que hay que definir en la configuración:
#   backup_remoto: directorio donde se guardan los backups en el server
#   backup_local:  directorio donde se guardan los backups en la máquina local
namespace :backup do
  # Depende de +yaml_db+
  desc "Genera un backup en .yml"
  task :default do
    run "mkdir -p #{shared_path}/#{backup_remoto}; cd #{current_path}; #{rake} db:data:dump_dir; mv db/20* #{shared_path}/#{backup_remoto}"
  end

  desc "Copia los backups generados a localhost"
  task :localmente, roles: :db do
    find_servers_for_task(current_task).each do |server|
      puts run_locally "#{rsync} #{user}@#{server.host}:#{shared_path}/#{backup_remoto}/ #{backup_local}"
    end
  end
end
