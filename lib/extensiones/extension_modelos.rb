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

    # Para guardar una serie (+Array+) de ids de una asociación en una misma
    # columna de la BD. Útil para los ActiveHash
    def guardar_como_arreglo(asociacion, clase)

      # Defino el método asociacion_ids= que sincroniza la serialización con la
      # variable de instancia @asociaciones
      define_method "#{asociacion}_ids=" do |ids|
        super Array.wrap(ids.reject(&:blank?).reject { |id| id > clase.count })
        cargar_ids_para asociacion, clase
      end

      # Después de inicializar carga la variable de instancia con las instancias
      # de la asociación
      after_initialize do
        cargar_ids_para asociacion, clase
      end

      # Antes de validar guarda los ids de las asociación en la variable de
      # instancia en la columna +asociacion_ids+
      before_validation do
        guardar_ids_para asociacion
      end

    end

  end

# Métodos de instancia

  included do

    # asociacion_ids = @asociaciones.collect(&:id).uniq.sort
    def guardar_ids_para(asociacion)
      self.send(
        "#{asociacion}_ids=",
        instance_variable_get("@#{asociacion.to_s.pluralize}").collect(&:id).uniq.sort)
    end

    # @asociaciones = clase.find asociacion_ids.sort
    def cargar_ids_para(asociacion, clase)
      instance_variable_set(
        "@#{asociacion.to_s.pluralize}",
        clase.find(self.send("#{asociacion}_ids").sort))
    end

    # Atributos virtuales para usar con el FormBuilder, para nulificar una
    # asociación en vez de destruirla con _destroy
    def anular
      false
    end
    def anular=(asociacion)
      self.send("#{asociacion}=", nil)
    end

  end

end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, ExtensionModelos)
