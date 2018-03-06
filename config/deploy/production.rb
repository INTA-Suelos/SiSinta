set :deploy_user, ENV['DEPLOY_USER']
set :deploy_to, ENV['DEPLOY_PATH']

# Which branch to deploy, master by default
set :deploy_branch, ENV['DEPLOY_BRANCH']
set :branch, fetch(:deploy_branch, :master)

# How to provision server configuration files with capistrano-config_provider
set :config_strategy, ENV['CONFIG_STRATEGY']
set :config_repo_url, ENV['CONFIG_SOURCE']
set :config_local_path, ENV['CONFIG_SOURCE']

# How to restart the webserver
set :passenger_restart_with_sudo, false

server ENV['DEPLOY_SERVER'], user: fetch(:deploy_user), roles: %w{app web db}
