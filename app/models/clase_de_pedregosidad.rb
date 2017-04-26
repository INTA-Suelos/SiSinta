# Mantiene los valores posibles para la Clase de Pedregosidad en la ficha de
# Perfiles
class ClaseDePedregosidad < ActiveRecord::Base
  has_many :pedregosidades, inverse_of: :clase

  validates :valor, presence: true
end
