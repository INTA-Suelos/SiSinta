# encoding: utf-8
class Posicion < Lookup
  has_many :calicatas, inverse_of: :posicion
end
