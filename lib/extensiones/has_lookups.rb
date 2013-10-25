# encoding: utf-8
# Para relacionar modelos con las tablas de Lookup, o sea, tablas de valores
# que no cambian, son practicamente configuración. Actualmente implementadas
# como ActiveHash y definidas en db/semillas
#
# La asociación es 1 a 1:
#   belongs_to => perfil tiene lookup_id
#
# Como los valores de estas tablas son un conjunto definido, se comparten
# entre todos los perfiles, aunque suene raro un belongs_to.
module HasLookups
  extend ActiveSupport::Concern

  module ClassMethods
    # Define varios lookups
    def has_lookups(*lookups)
      lookups.each do |lookup|
        has_lookup lookup, { }
      end
    end

    # Define un lookup con opciones.
    def has_lookup(lookup, opciones_para_active_hash = {})
      # Nos da belongs_to_active_hash para las asociaciones con modelos
      # estáticos
      extend ActiveHash::Associations::ActiveRecordExtensions

      # Permite símbolos pero usa strings
      lookup = lookup.to_s

      # Define la relación con el ActiveHash
      belongs_to lookup, opciones_para_active_hash

      # Define un ransacker para cada lookup. Esto sirve para poder hacer
      # búsquedas con Ransack por el valor del lookup aunque la base de datos
      # guarde el ID
      ransacker lookup, formatter: proc { |v|
          lookup.classify.constantize.find_by_valor(v).id
        } do |parent|
        parent.table["#{lookup}_id"]
      end

      # Mantiene un array de todos los lookups definidos
      cattr_reader :lookups
      self.class_variable_set '@@lookups', [] if self.lookups.nil?
      self.lookups << lookup

      # Redefine ransackable_attributes y ransackable_associations
      include HasLookups::Ransackables
    end
  end

end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, HasLookups)
