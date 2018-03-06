# Config valid only for this version of Capistrano
lock '3.10.1'

set :application, 'SiSINTA'
set :repo_url, 'https://github.com/INTA-Suelos/SiSinta.git'

# Capistrano defaults
set :branch, :master
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

# rbenv
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

# Configuration files adapted to the deploy server. You need to provision these
# somehow
set :linked_files, %w{
  config/secrets.yml
  config/database.yml
  config/environments/production.rb
  config/initializers/devise.rb
}
