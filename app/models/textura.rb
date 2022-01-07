# Mantiene los valores posibles para Textura en cada Horizonte de la ficha de
# perfiles.
class Textura < ApplicationRecord
  has_many :horizontes, inverse_of: :textura

  validates :clase, presence: true
end
