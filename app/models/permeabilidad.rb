# encoding: utf-8
class Permeabilidad < Lookup
  has_many :perfiles, inverse_of: :permeabilidad

  field :valor
end
