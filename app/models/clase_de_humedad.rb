# Mantiene los valores posibles para la Clase de Humedad en la ficha de
# Perfiles
class ClaseDeHumedad < ApplicationRecord
  has_many :humedades, inverse_of: :clase, foreign_key: :clase_id

  validates :valor, presence: true
end
