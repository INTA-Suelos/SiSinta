set :deploy_user, 'sisar'
set :deploy_to, '/srv/http/sisar.inta.gob.ar'

# Cómo subir la configuración de la app al server
set :config_strategy, 'config:dir'

# Cómo reiniciar el webserver
set :passenger_restart_with_sudo, false

set :branch, 'master'

server 'sisar.inta.gob.ar', user: fetch(:deploy_user), roles: %w{app web db}
