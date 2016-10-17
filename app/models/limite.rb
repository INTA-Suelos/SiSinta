# Modelo asociativo (no tiene datos propios) para los valores (forma y
# tipo) de Límite en la ficha de Perfiles para cada Horizonte
class Limite < ActiveRecord::Base
  belongs_to :horizonte
  belongs_to :forma, inverse_of: :limites, class_name: 'FormaDeLimite'
  belongs_to :tipo, inverse_of: :limites, class_name: 'TipoDeLimite'

  validates :horizonte, presence: true

  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
