require 'csv'

namespace :sisinta do
  namespace :importar do
    desc "Importar perfiles de csv en el formato que exportamos"
    task :csv => :environment do
      # El archivo .csv
      if (archivo = ENV['archivo']).present? && File.exists?(archivo)
        actualizar = ENV['actualizar'].present?
        perfil_id = ENV['id'] || 'id'

        perfiles = Deserializador.parsear_csv archivo, perfil_id

        Deserializador.construir_perfiles(perfiles,
          usuario: ENV['usuario'], actualizar: actualizar
        ).each do |perfil|
          unless perfil.save
            ap perfil.errors.messages
          end
        end
      else
        puts 'Especificá el archivo con rake sisinta:importar:csv archivo=sarasa.csv'
      end
    end
  end
end
