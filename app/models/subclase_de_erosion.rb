# Mantiene los valores posibles para la Subclase de Erosión en la ficha de
# Perfiles
class SubclaseDeErosion < ActiveRecord::Base
  has_many :erosiones, inverse_of: :subclase, foreign_key: :subclase_id

  validates :valor, presence: true

  def acumulacion?
    valor == 'acumulación'
  end
end
