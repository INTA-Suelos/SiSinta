# Mantiene los valores posibles de adhesividad de consistencia para cada Horizonte
class Adhesividad < ActiveRecord::Base
  include Mostrable

  has_many :consistencias, inverse_of: :adhesividad, foreign_key: :adhesividad_id

  # Globalize recomienda sacar las columnas originales, pero validamos los setters
  validates :valor, presence: true, uniqueness: true

  active_admin_translates :valor, touch: true
end
