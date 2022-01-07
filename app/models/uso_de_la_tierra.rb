# Mantiene los valores posibles para Uso de la tierra en la ficha de perfiles.
class UsoDeLaTierra < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
