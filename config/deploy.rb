require 'bundler/capistrano'
require 'capistrano-rbenv'

load 'lib/recipes/backup'
load 'lib/recipes/configs'
load 'lib/recipes/precompilar_localmente'
load 'lib/recipes/thin'

set :application, 'SiSINTA'

server            'sisinta.inta.gov.ar', :app, :web, :db, primary: true
set :user,        'sisinta'
set :deploy_to,   '/srv/sisinta/app'

set :use_sudo,    false
set :ssh_options, { forward_agent: true}

set :scm,         :git
set :repository,  'https://github.com/INTA-Suelos/SiSinta.git'

set :keep_releases, 5

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

set :assets_prefix, 'estaticos'
set :rake, 'RAILS_ENV=production bundle exec rake'

set :config_path, fetch(:config_path, 'tmp/config')

set :rbenv_ruby_version, '2.1.2'
set :rbenv_ruby_dependencies, [] # Instalamos las dependencias a mano
# Path para que capistrano detecte rbenv
set :default_environment, { 'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }

set :bundle_flags, '--deployment --quiet --binstubs'

set :backup_remoto, 'backups-yml'
set :backup_local, 'tmp/backups'

set :rsync, 'rsync -avzh --rsh=ssh'

namespace :deploy do
  namespace :assets do
    desc "Construye los estilos nuevos de paperclip"
    task :refresh_styles, roles: :app do
      run "cd #{release_path}; #{rake} paperclip:refresh:missing_styles"
    end
  end
end

after   'deploy:setup',           'configs:directorios'
after   'deploy:setup',           'configs:archivos'
after   'deploy:restart',         'deploy:cleanup'
after   'deploy:update_code',     'deploy:assets:precompilar_localmente'
before  'deploy:finalize_update', 'backup'
after   'backup',                 'backup:localmente'
before  'deploy:finalize_update', 'configs:links'
