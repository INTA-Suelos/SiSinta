# Mantiene los valores posibles para Posición en la ficha de perfiles.
class Posicion < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
