class UsoTierra < Lookup
  alias_attribute :valor, :valor1

  has_many :calicatas, :inverse_of => :uso_tierra
end
