class Permeabilidad < Lookup
  has_many :calicatas, :inverse_of => :permeabilidad
end
