# Mantiene los valores posibles para la Clase de Erosión en la ficha de
# Perfiles
class ClaseDeErosion < ActiveRecord::Base
  include Mostrable

  has_many :erosiones, inverse_of: :clase, foreign_key: :clase_id

  # Globalize recomienda sacar las columnas originales, pero validamos los setters
  validates :valor, presence: true, uniqueness: true

  active_admin_translates :valor,
    # Necesitamos especificar la foreign_key por una cuestión de pluralización
    touch: true, foreign_key: :clase_de_erosion_id
end
