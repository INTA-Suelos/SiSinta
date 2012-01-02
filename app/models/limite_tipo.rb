class LimiteTipo < Lookup
  alias_attribute :valor, :valor1

  has_many :limites, :inverse_of => :tipo
  has_many :horizontes, :through => :limites
end
