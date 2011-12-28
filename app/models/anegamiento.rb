class Anegamiento < Lookup
  alias_attribute :valor, :valor1

  has_many :calicatas, :inverse_of => :anegamiento
end
