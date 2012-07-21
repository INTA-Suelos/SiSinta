# encoding: utf-8
class Estructura < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :estructura
  belongs_to :tipo, inverse_of: :estructuras, class_name: 'TipoDeEstructura'
  belongs_to :clase, inverse_of: :estructuras, class_name: 'ClaseDeEstructura'
  belongs_to :grado, inverse_of: :estructuras, class_name: 'GradoDeEstructura'

  validates_presence_of :horizonte
end
