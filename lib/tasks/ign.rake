require 'ign'

namespace :sisinta do
  namespace :importar do
    namespace :ign do
      desc 'Importa shapefiles con información geográfica de provincias a la DB'
      task provincias: :environment do
        Ign.new('provincias').hacer_todo
      end
    end
  end
end
