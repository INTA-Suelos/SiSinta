# encoding: utf-8
class SubclaseDeHumedad < Lookup
  has_many :humedades, inverse_of: :subclase, foreign_key: 'subclase_id'
end
