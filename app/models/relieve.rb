# encoding: utf-8
class Relieve < Lookup
  has_many :perfiles, inverse_of: :relieve

  field :valor
end
