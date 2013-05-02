# encoding: utf-8
class UsoDeLaTierra < Lookup
  has_many :perfiles, inverse_of: :uso_de_la_tierra

  field :valor
end
