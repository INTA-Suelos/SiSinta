# Mantiene los valores posibles para la Subclase de Capacidad en la ficha de
# Perfiles
class SubclaseDeCapacidad < ApplicationRecord
  has_and_belongs_to_many :capacidades, inverse_of: :subclases

  validates :codigo, presence: true
end
