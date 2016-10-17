# Mantiene los valores posibles de adhesividad de consistencia para cada Horizonte
class Adhesividad < ActiveRecord::Base
  has_many :consistencias, inverse_of: :adhesividad, foreign_key: 'adhesividad_id'

  validates :valor, presence: true
end
