# Mantiene los valores posibles para la Subclase de Pedregosidad en la ficha de
# Perfiles
class SubclaseDePedregosidad < ActiveRecord::Base
  has_many :pedregosidades, inverse_of: :subclase

  validates :valor, presence: true
end
