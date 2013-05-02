# encoding: utf-8
class Posicion < Lookup
  has_many :perfiles, inverse_of: :posicion

  field :valor
end
