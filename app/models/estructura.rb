# encoding: utf-8
class Estructura < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_accessible :tipo_id, :clase_id, :grado_id

  belongs_to :horizonte, inverse_of: :estructura
  belongs_to_active_hash :tipo, inverse_of: :estructuras, class_name: 'TipoDeEstructura'
  belongs_to_active_hash :clase, inverse_of: :estructuras, class_name: 'ClaseDeEstructura'
  belongs_to_active_hash :grado, inverse_of: :estructuras, class_name: 'GradoDeEstructura'

  validates_presence_of :horizonte
end
