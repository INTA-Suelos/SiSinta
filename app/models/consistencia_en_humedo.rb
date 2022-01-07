# Mantiene los valores posibles de consistencia en húmedo para cada Horizonte
class ConsistenciaEnHumedo < ApplicationRecord
  has_many :consistencias, inverse_of: :en_humedo, foreign_key: :en_humedo_id

  validates :valor, presence: true
end
