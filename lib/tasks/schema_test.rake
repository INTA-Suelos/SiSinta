# Para cargar los datos de las semillas en la base de datos de prueba
namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end
