# Mantiene los valores posibles para Permeabilidad en la ficha de perfiles.
class Permeabilidad < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
