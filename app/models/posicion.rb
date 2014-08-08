# encoding: utf-8
class Posicion < Lookup
  has_many :perfiles

  field :valor
end
