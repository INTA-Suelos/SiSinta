# Mantiene los valores posibles para la Forma de Límite de un Horizonte en la
# ficha de Perfiles
class FormaDeLimite < ActiveRecord::Base
  has_many :limites, inverse_of: :forma, foreign_key: :forma_id

  validates :valor, presence: true
end
