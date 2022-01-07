# Mantiene los valores posibles para Drenaje en la ficha de perfiles.
class Drenaje < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
