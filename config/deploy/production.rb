set :deploy_user, 'sisinta'
set :deploy_to, '/srv/sisinta/app'

set :branch, 'master'

server 'sisinta.inta.gov.ar', user: fetch(:deploy_user), roles: %w{app web db}
