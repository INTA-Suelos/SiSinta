# encoding: utf-8
# Precompilar los assets localmente
namespace :deploy do
  namespace :assets do
    task :precompilar_localmente, :roles => :web do
      run_locally("#{rake} assets:clean && #{rake} assets:precompile")
      find_servers_for_task(current_task).each do |server|
        run_locally "#{rsync} public/#{assets_prefix}/ #{user}@#{server.host}:#{shared_path}/assets"
      end
      run_locally("#{rake} assets:clean")
    end

    desc 'Sobreescribo :precompile para que no haga nada'
    task :precompile do
    end
  end
end
