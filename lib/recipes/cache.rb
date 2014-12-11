# encoding: utf-8
# Recetas para Capistrano relacionadas con el cache
namespace :cache do
  desc 'Para limpiar el cache después del deployment'
  task :clear, :roles => :app do
    run "cd #{current_release} && rake cache:clear RAILS_ENV=production"
  end
end
