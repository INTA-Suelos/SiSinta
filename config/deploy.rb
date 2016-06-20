# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'SiSINTA'
set :repo_url, 'https://github.com/INTA-Suelos/SiSinta.git'

# Defaults de capistrano
set :branch, :master
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

# rbenv
set :rbenv_ruby, '2.3.1'
set :rbenv_type, :user

# rails
set :assets_prefix, 'estaticos'
set :linked_dirs, %w{
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
}
set :linked_files, %w{
  config/secrets.yml
  config/database.yml
  config/environments/production.rb
  config/initializers/devise.rb
}

after 'deploy:finished', 'deploy:restart'
