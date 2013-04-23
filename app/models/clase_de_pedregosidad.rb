# encoding: utf-8
class ClaseDePedregosidad < Lookup
  has_many :pedregosidades, inverse_of: :clase, foreign_key: 'clase_id'

  field :valor
end
