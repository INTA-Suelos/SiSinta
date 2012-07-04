# encoding: utf-8
module ExtensionModelos
  extend ActiveSupport::Concern

  module ClassMethods

    # Este método es llamado para generar el formulario de exportar/importar CSV.
    # Utiliza los atributos del modelo y sus asociaciones.
    #
    # * *Devuelve* : la lista de atributos para exportar/importar como CSV
    #
    def atributos_y_asociaciones(opciones = nil)
      opciones ||= {}
      excepto = Array.wrap(opciones[:excepto])

      # Selecciono los nombres de atributos que no son obvias llaves externas
      # (*_id). Si hay llaves externas sin este formato, hay que agregarlas al
      # hash +:excepto+.
      atributos = self.attribute_names.map {|s| s.to_sym}.reject {|n| n =~ /_id$/ or excepto.include? n }

      # Rechazo las asociaciones de tipo +:through+
      atributos << self.reflections.reject do |k,v|
        not v.instance_of?(ActiveRecord::Reflection::AssociationReflection)
      end.keys.reject {|n| excepto.include? n}
      atributos.flatten.sort
    end

  end

# Métodos de instancia

  included do
    # Construye los objetos asociados al modelo, para usar con el +FormHelper+, si es que no
    # existen ya.
    #
    # * *Args*    :
    #   - +asociaciones+ -> la lista de asociaciones que construir
    # * *Returns* :
    #   - el modelo con las asociaciones cargadas
    #
    def preparar(*asociaciones)
      asociaciones.each do |asociacion|
        self.send("build_#{asociacion}") if self.send(asociacion).nil?
      end
      return self
    end

    def como_arreglo(filtro = nil)
      filtro ||= attributes.keys.flatten
      filtro.inject([]) do |arreglo, atributo|
        arreglo << self.send(atributo)
      end
    end

    # Busca las asociaciones indicadas por si ya existen, para no duplicar.
    # Opcionalmente las crea.
    def buscar_asociaciones(asociaciones = {}, crear = false)
      asociaciones.each_pair do |modelo,metodo|
        unless self.send(modelo).try(metodo).blank?
          clase = self.association(modelo).reflection.klass

          # asociacion = Asociacion.find_by_metodo(self.asociacion.metodo)
          # asociacion = Asociacion.find_or_create_by_metodo(self.asociacion.metodo)
          self.send(  "#{modelo}=", #
                      clase.send("find#{crear ? '_or_create' : nil}_by_#{metodo}",
                          self.send(modelo).try(metodo) ) )
        end
      end
    end

  end

end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, ExtensionModelos)
