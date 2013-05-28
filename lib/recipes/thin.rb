# encoding: utf-8
# Control de las instancias de thin. Hay que configurar el acceso al script de
# control en el server para el usuario de capistrano
namespace :deploy do
  desc "Iniciar los thin"
  task :start do
    run "sudo /etc/init.d/thin start"
  end

  desc "Reiniciar los thin"
  task :restart do
    run "sudo /etc/init.d/thin restart"
  end

  desc "Parar los thin"
  task :stop do
    run "sudo /etc/init.d/thin stop"
  end
end
