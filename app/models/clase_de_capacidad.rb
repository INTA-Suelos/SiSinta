# Mantiene los valores posibles para la Clase de Capacidad en la ficha de
# Perfiles
class ClaseDeCapacidad < ActiveRecord::Base
  has_many :capacidades, inverse_of: :clase, foreign_key: :clase_id

  validates :codigo, presence: true
end
