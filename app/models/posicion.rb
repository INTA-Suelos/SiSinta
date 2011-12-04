class Posicion < Lookup
  has_many :calicatas, :inverse_of => :calicatas
end
