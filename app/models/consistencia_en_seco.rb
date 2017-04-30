# Mantiene los valores posibles de consistencia en seco para cada Horizonte
class ConsistenciaEnSeco < ActiveRecord::Base
  has_many :consistencias, inverse_of: :en_seco, foreign_key: :en_seco_id

  validates :valor, presence: true
end
