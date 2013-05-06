require 'bundler/capistrano'
require 'capistrano-rbenv'

set :application, "SiSINTA"

server            "sisinta.inta.gov.ar", :app, :web, :db, primary: true
set :user,        "sisinta"
set :deploy_to,   "/srv/sisinta/app"

set :use_sudo,    false
set :ssh_options, { forward_agent: true}

set :scm,         :git
set :repository,  "https://github.com/INTA-Suelos/SiSinta.git"

set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

set :assets_prefix, "estaticos"
set :rake, "RAILS_ENV=production bundle exec rake"

set :config_path, fetch(:config_path, "tmp/config")

set :rbenv_ruby_version, '1.9.3-p392'
set :rbenv_ruby_dependencies, [] # Instalamos las dependencias a mano
# Path para que capistrano detecte rbenv
set :default_environment, { 'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }

set :bundle_flags, "--deployment --quiet --binstubs"

set :backup_remoto, 'backups-yml'
set :backup_local, 'tmp/backups'

namespace :backup do
  desc "Genera un backup en .yml"
  task :default do
    run "cd #{current_path}; #{rake} db:data:dump_dir; mv db/20* #{shared_path}/#{backup_remoto}"
  end

  desc "Copia los backups generados a localhost"
  task :localmente, roles: :db do
    find_servers_for_task(current_task).each do |server|
      puts run_locally "rsync -av #{user}@#{server.host}:#{shared_path}/#{backup_remoto}/ #{backup_local}"
    end
  end
end

namespace :deploy do
  namespace :assets do
    desc "Construye los estilos nuevos de paperclip"
    task :refresh_styles, roles: :app do
      run "cd #{release_path}; #{rake} paperclip:refresh:missing_styles"
    end
  end
end

namespace :configs do
  desc "Crea el directorio para los archivos de configuración"
  task :directorios, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/backups-yml"
    run "mkdir -p #{shared_path}/sockets"
  end

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

after   "deploy:setup",           "configs:directorios"
after   "deploy:setup",           "configs:archivos"
before  "deploy:finalize_update", "backup"
before  "deploy:finalize_update", "configs:links"
