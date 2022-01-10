# Config valid only for this version of Capistrano
lock '3.10.1'

set :application, 'SiSINTA'
set :repo_url, 'https://github.com/INTA-Suelos/SiSinta.git'
set :branch, ENV['DEPLOY_BRANCH'] || :master

# Capistrano defaults
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

# rails
set :linked_dirs, %w{
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
}

# Configuration files adapted to the deploy server. You need to provision these
# somehow
set :linked_files, %w{
  config/secrets.yml
  config/database.yml
  config/environments/production.rb
  config/initializers/devise.rb
}

# Puma.
set :puma_preload_app, true
set :puma_init_active_record, true
set :systemd_service_name, 'sisinta.service'

after 'deploy', 'deploy:restart'
