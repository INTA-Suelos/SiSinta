# Mantiene los valores posibles de adhesividad de consistencia para cada Horizonte
class Adhesividad < ApplicationRecord
  include Mostrable

  has_many :consistencias, inverse_of: :adhesividad,
    foreign_key: :adhesividad_id, dependent: :restrict_with_error

  # Globalize recomienda sacar las columnas originales, pero validamos los setters
  validates :valor, presence: true, uniqueness: true

  active_admin_translates :valor, touch: true
end
