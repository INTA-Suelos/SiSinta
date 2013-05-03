# encoding: utf-8
class ClaseDeHumedad < Lookup
  has_many :humedades, inverse_of: :clase, foreign_key: 'clase_id'

  field :valor
end
