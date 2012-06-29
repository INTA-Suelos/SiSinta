class Limite < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :limite
  belongs_to :forma, :inverse_of => :limites, :class_name => 'FormaDeLimite'
  belongs_to :tipo, :inverse_of => :limites, :class_name => 'TipoDeLimite'

  validates_presence_of :horizonte
end
