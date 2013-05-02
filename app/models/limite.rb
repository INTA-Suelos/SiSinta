# encoding: utf-8
class Limite < ActiveRecord::Base
  attr_accessible :tipo_id, :forma_id

  belongs_to :horizonte, inverse_of: :limite
  has_lookup :forma, inverse_of: :limites, class_name: 'FormaDeLimite'
  has_lookup :tipo, inverse_of: :limites, class_name: 'TipoDeLimite'

  validates_presence_of :horizonte
  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
