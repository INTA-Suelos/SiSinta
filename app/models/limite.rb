# encoding: utf-8
class Limite < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_accessible :tipo_id, :forma_id

  belongs_to :horizonte, inverse_of: :limite
  belongs_to_active_hash :forma, inverse_of: :limites, class_name: 'FormaDeLimite'
  belongs_to_active_hash :tipo, inverse_of: :limites, class_name: 'TipoDeLimite'

  validates_presence_of :horizonte
  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
