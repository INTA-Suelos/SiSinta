# Mantiene los valores posibles para Posición en la ficha de perfiles.
class Posicion < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
