# Mantiene los valores posibles de plasticidad de consistencia para cada Horizonte
class Plasticidad < ActiveRecord::Base
  has_many :consistencias, inverse_of: :plasticidad, foreign_key: 'plasticidad_id'

  validates :valor, presence: true
end
