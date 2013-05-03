# encoding: utf-8
class SubclaseDePedregosidad < Lookup
  has_many :pedregosidades, inverse_of: :subclase, foreign_key: 'subclase_id'

  field :valor
end
