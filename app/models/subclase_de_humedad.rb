# encoding: utf-8
class SubclaseDeHumedad < Lookup
  has_many :humedades, inverse_of: :clase, foreign_key: 'subclase_id'
end
