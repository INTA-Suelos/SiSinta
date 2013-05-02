# encoding: utf-8
class Lookup < ActiveYaml::Base
  include ActiveHash::Associations
  extend ActiveModel::Translation

  # Guardo en semillas todos los .yml con los datos de las clases que heredan de
  # Lookup. Cada una busca el plural de su nombre acá.
  set_root_path "db/semillas"

  def to_str
    self.valor
  end
  alias_method :to_str, :to_s

  def self.se_asocia_con(asociacion, opciones)
    columna = opciones[:como].present? ? opciones[:como] : self.to_s.underscore
    clase = asociacion.to_s.singularize.camelcase.safe_constantize

    define_method asociacion.to_s.pluralize do
      clase.where(clase.arel_table["#{columna}_ids"].matches("%#{self.id}%"))
    end
  end

  # Así ransack sabe cómo "klasificarlos"
  def self.klass
    self
  end
end
