class LimiteForma < Lookup
  alias_attribute :valor, :valor1

  has_many :limites, :inverse_of => :forma
  has_many :horizontes, :through => :limites
end
