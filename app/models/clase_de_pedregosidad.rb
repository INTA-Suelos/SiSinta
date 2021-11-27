# Mantiene los valores posibles para la Clase de Pedregosidad en la ficha de
# Perfiles
class ClaseDePedregosidad < ApplicationRecord
  has_many :pedregosidades, inverse_of: :clase, foreign_key: :clase_id

  validates :valor, presence: true
end
