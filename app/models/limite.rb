class Limite < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :limite
  belongs_to :forma, :inverse_of => :limites, :class_name => 'LimiteForma'
  belongs_to :tipo, :inverse_of => :limites, :class_name => 'LimiteTipo'

  validates_presence_of :horizonte
end
