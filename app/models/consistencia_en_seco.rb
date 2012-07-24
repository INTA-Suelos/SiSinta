# encoding: utf-8
class ConsistenciaEnSeco < Lookup
  has_many :consistencias, inverse_of: :en_seco, foreign_key: 'en_seco_id'
end
