# Mantiene los valores posibles para la Subclase de Pedregosidad en la ficha de
# Perfiles
class SubclaseDePedregosidad < ApplicationRecord
  has_many :pedregosidades, inverse_of: :subclase, foreign_key: :subclase_id

  validates :valor, presence: true
end
