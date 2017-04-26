# Mantiene los valores posibles para las Clase de Estructura en la ficha de
# Perfiles
class ClaseDeEstructura < ActiveRecord::Base
  has_many :estructuras, inverse_of: :clase

  validates :valor, uniqueness: true
end
