class Pedregosidad < Lookup
  alias_attribute :valor, :valor1

  has_many :calicatas, :inverse_of => :pedregosidad
end
