class TipoDeLimite < Lookup
  has_many :limites, :inverse_of => :tipo
  has_many :horizontes, :through => :limites
end
