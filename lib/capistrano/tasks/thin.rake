# encoding: utf-8
# Control de las instancias de thin. Hay que configurar el acceso al script de
# control en el server para el usuario de capistrano
namespace :deploy do
  desc 'Iniciar los thin'
  task :start do
    on roles(:web) do
      sudo '/etc/init.d/thin', 'start'
    end
  end

  desc 'Reiniciar los thin'
  task :restart do
    on roles(:web) do
      sudo '/etc/init.d/thin', 'restart'
    end
  end

  desc 'Parar los thin'
  task :stop do
    on roles(:web) do
      sudo '/etc/init.d/thin', 'stop'
    end
  end
end
