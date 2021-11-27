# Mantiene los valores posibles para Relieve en la ficha de perfiles.
class Relieve < ApplicationRecord
  has_many :perfiles

  validates :valor, presence: true
end
