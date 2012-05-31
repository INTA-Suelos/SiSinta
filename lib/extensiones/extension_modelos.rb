# -*- encoding : utf-8 -*-
module ExtensionModelos
  extend ActiveSupport::Concern

  module ClassMethods

    #
    # Este método es llamado para generar el formulario de exportar/importar CSV.
    # Utiliza los atributos del modelo y sus asociaciones.
    #
    # * *Devuelve* : la lista de atributos para exportar/importar como CSV
    #
    def atributos_y_asociaciones(opciones = nil)
      opciones ||= {}
      excepto = Array.wrap(opciones[:excepto])

      atributos = self.attribute_names.map {|s| s.to_sym}.reject {|n| excepto.include? n}
      atributos << self.reflections.keys.reject {|n| excepto.include? n}
      atributos.flatten
    end

  end

# Métodos de instancia

  included do
    #
    # Construye los objetos asociados al modelo, para usar con el +FormHelper+, si es que no
    # existen ya.
    #
    # * *Args*    :
    #   - +asociaciones+ -> la lista de asociaciones que construir
    # * *Returns* :
    #   - el modelo con las asociaciones preparadas
    #
    def preparar(asociaciones)
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

    def buscar_asociaciones(asociaciones = {}, crear = false)
      asociaciones.each_pair do |modelo,metodo|
        if self.send(modelo).try(metodo).present? then
          clase = self.association(modelo).reflection.klass
          self.send(  "#{modelo}=",
                      clase.send("find#{crear ? '_or_create' : nil}_by_#{metodo}",
                        self.send(modelo).send(metodo)
                      )
                    )
        else
          self.send("#{modelo}=", nil)
        end
      end
    end

  end

end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, ExtensionModelos)
