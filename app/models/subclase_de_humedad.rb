# Mantiene los valores posibles para la Subclase de Humedad en la ficha de
# Perfiles
class SubclaseDeHumedad < ActiveRecord::Base
  has_and_belongs_to_many :humedades, inverse_of: :subclases

  validates :valor, presence: true
end
