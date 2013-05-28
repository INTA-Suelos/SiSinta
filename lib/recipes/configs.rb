# encoding: utf-8
# Recetas de Capistrano para configurar la aplicación
namespace :configs do
  # Debería ser linkeada después de +deploy:setup+
  desc "Crea el directorio para los archivos de configuración"
  task :directorios, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/backups-yml"
    run "mkdir -p #{shared_path}/sockets"
  end

  # Debería ser linkeada después de +deploy:setup+
  desc "Copia los archivos de configuración iniciales"
  task :archivos, roles: :app do
    upload "#{config_path}/$CAPISTRANO:HOST$/devise.rb",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/secret_token.rb",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/database.yml",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/production.rb",
              "#{shared_path}/config/", via: :scp
  end

  desc "Crea los links simbólicos de los archivos de configuración"
  task :links, roles: :app do
    run "ln -s #{shared_path}/config/devise.rb #{release_path}/config/initializers/devise.rb"
    run "ln -s #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"

    run "mkdir -p #{release_path}/tmp"
    run "ln -s #{shared_path}/sockets #{release_path}/tmp/"
  end
end
