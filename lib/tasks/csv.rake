# Con docker:
# docker compose cp archivo.csv app:/home/app/perfiles.csv
# docker compose exec app rake sisinta:importar:csv archivo=perfiles.csv
require 'csv'

namespace :sisinta do
  namespace :importar do
    desc "Importar perfiles de csv en el formato que exportamos"
    task :csv => :environment do
      # El archivo .csv
      if (archivo = ENV['archivo']).present? && File.exists?(archivo)
        perfiles = Deserializador.parsear_csv archivo, :id

        Deserializador.construir_perfiles(perfiles, ENV['usuario']).each do |perfil|
          unless perfil.save
            puts "Ocurrió un error con estos horizontes:"
            pp perfil.horizontes
          end
        end
      else
        puts 'Especificá el archivo con rake sisinta:importar:csv archivo=sarasa.csv'
      end
    end
  end
end
