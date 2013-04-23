# encoding: utf-8
class ClaseDeErosion < Lookup
  has_many :erosiones, inverse_of: :clase, foreign_key: 'clase_id'

  field :valor
end
