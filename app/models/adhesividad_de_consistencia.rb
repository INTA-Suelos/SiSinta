# encoding: utf-8
class AdhesividadDeConsistencia < Lookup
  has_many :consistencias, inverse_of: :adhesividad, foreign_key: 'adhesividad_id'
end
