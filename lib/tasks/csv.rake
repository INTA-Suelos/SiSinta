require 'csv'

namespace :sisinta do
  namespace :importar do
    desc "Importar perfiles de csv en el formato que exportamos"
    task :csv => :environment do

      usuario = Usuario.find_by(email: ENV['usuario'])

      # El archivo .csv
      if (archivo = ENV['archivo']).present? && File.exists?(archivo)
        perfiles = Deserializador.parsear_perfiles_de_csv archivo

        perfiles.each do |id, horizontes|
          des = Deserializador.new(horizontes, usuario)

          perfil = des.construir_horizontes(des.construir_perfil)

          unless perfil.save
            puts "Ocurrió un error con el perfil #{id} y estos horizontes:"
            ap horizontes
          end
        end
      else
        puts 'Especificá el archivo con rake sisinta:importar:csv archivo=sarasa.csv'
      end
    end
  end
end
