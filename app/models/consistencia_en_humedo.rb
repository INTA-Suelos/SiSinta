# encoding: utf-8
class ConsistenciaEnHumedo < Lookup
  has_many :consistencias, inverse_of: :en_humedo, foreign_key: 'en_humedo_id'
end
