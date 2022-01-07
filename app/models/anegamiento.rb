# Mantiene los valores posibles para Anegamiento en la ficha de perfiles.
class Anegamiento < ApplicationRecord
  include Mostrable

  has_many :perfiles, dependent: :restrict_with_error

  # Globalize recomienda sacar las columnas originales, pero validamos los setters
  validates :valor, presence: true, uniqueness: true

  active_admin_translates :valor, touch: true
end
