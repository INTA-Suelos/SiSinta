set :deploy_user, 'sisinta'
set :deploy_to, '/srv/sisinta/app'

# Repositorio con la configuración de este server
set :config_repo_url, 'gogs@code.mauriciopasquier.com.ar:inta/sisar-config.git'

set :branch, 'master'

server 'sisinta.inta.gov.ar', user: fetch(:deploy_user), roles: %w{app web db}
