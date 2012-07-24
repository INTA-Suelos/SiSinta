# encoding: utf-8
class ClaseDeEstructura < Lookup
  has_many :estructuras, inverse_of: :clase, foreign_key: 'clase_id'
end
