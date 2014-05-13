# encoding: utf-8
class Estructura < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :estructura
  has_lookup :tipo, inverse_of: :estructuras, class_name: 'TipoDeEstructura'
  has_lookup :clase, inverse_of: :estructuras, class_name: 'ClaseDeEstructura'
  has_lookup :grado, inverse_of: :estructuras, class_name: 'GradoDeEstructura'

  validates_presence_of :horizonte
  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
