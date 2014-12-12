# config valid only for current version of Capistrano
lock '3.3.4'

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
set :rbenv_ruby, '2.1.2'
set :rbenv_type, :user

# rails
set :assets_prefix, 'estaticos'
set :linked_dirs, %w{
  bin
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
}
set :linked_files, %w{
  config/database.yml
  config/environments/production.rb
  config/initializers/secret_token.rb
  config/initializers/devise.rb
}
