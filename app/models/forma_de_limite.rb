class FormaDeLimite < Lookup
  has_many :limites, :inverse_of => :forma
  has_many :horizontes, :through => :limites
end
