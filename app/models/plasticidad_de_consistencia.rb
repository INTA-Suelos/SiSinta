# encoding: utf-8
class PlasticidadDeConsistencia < Lookup
  has_many :consistencias, inverse_of: :plasticidad, foreign_key: 'plasticidad_id'
end
