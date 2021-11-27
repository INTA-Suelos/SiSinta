# Mantiene los valores posibles para la Clase de Capacidad en la ficha de
# Perfiles
class ClaseDeCapacidad < ApplicationRecord
  include Mostrable
  alias_attribute :valor, :codigo

  has_many :capacidades, inverse_of: :clase,
    foreign_key: :clase_id, dependent: :restrict_with_error

  # Globalize recomienda sacar las columnas originales, pero validamos los setters
  validates :codigo, presence: true, uniqueness: true

  active_admin_translates :codigo, :descripcion, :categoria,
    # Necesitamos especificar la foreign_key por una cuestión de pluralización
    touch: true, foreign_key: :clase_de_capacidad_id
end
