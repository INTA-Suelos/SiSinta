set :deploy_user, ENV['DEPLOY_USER']
set :deploy_to, ENV['DEPLOY_PATH']

# How to restart the webserver
set :passenger_restart_with_sudo, false

server ENV['DEPLOY_SERVER'],
  user: fetch(:deploy_user),
  roles: %w{app web db}
