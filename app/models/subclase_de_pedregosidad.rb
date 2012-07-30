# encoding: utf-8
class SubclaseDePedregosidad < Lookup
  has_many :pedregosidades, inverse_of: :clase, foreign_key: 'subclase_id'
end
