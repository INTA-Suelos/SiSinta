# Mantiene los valores posibles para el Tipo de Límite de un Horizonte en la
# ficha de Perfiles
class TipoDeLimite < ActiveRecord::Base
  has_many :limites, inverse_of: :tipo, foreign_key: 'tipo_id'

  validates :valor, presence: true
end
