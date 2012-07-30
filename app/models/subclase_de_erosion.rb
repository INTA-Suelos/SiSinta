# encoding: utf-8
class SubclaseDeErosion < Lookup
  has_many :erosiones, inverse_of: :subclase, foreign_key: 'subclase_id'
end
