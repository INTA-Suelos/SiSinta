# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Tareas de assets y migración
require 'capistrano/rails'
require 'capistrano/rails/collection'

# Verifica que rbenv esté funcionando y lo agrega a los comandos
require 'capistrano/rbenv'

# Reinicia el server después del deploy
require 'capistrano/passenger'

# Provee la configuración privada del server en cada deploy
require 'capistrano/config_provider'

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
