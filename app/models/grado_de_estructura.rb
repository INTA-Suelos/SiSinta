# Mantiene los valores posibles para el Grado de Estructura en la ficha de
# Perfiles
class GradoDeEstructura < ApplicationRecord
  has_many :estructuras, inverse_of: :grado, foreign_key: :grado_id

  validates :valor, uniqueness: true
end
