class Lookup < ActiveRecord::Base
end

class Posicion < Lookup
  has_many :calicatas, :inverse_of => :calicatas
end

class Pendiente < Lookup
  has_many :calicatas, :inverse_of => :pendiente
end

class Escurrimiento < Lookup
  has_many :calicatas, :inverse_of => :escurrimiento
end

class Permeabilidad < Lookup
  has_many :calicatas, :inverse_of => :permeabilidad
end

class Drenaje < Lookup
  has_many :calicatas, :inverse_of => :drenaje
end

class Anegamiento < Lookup
  has_many :calicatas, :inverse_of => :anegamiento
end
