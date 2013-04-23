# encoding: utf-8
class Escurrimiento < Lookup
  has_many :perfiles, inverse_of: :escurrimiento

  field :valor
end
