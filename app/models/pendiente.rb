# Mantiene los valores posibles para Pendiente en la ficha de perfiles.
class Pendiente < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
