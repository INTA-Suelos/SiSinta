# Mantiene los valores posibles para el Tipo de Estructura en la ficha de
# Perfiles
class TipoDeEstructura < ActiveRecord::Base
  has_many :estructuras, inverse_of: :tipo

  validates :valor, uniqueness: true
end
