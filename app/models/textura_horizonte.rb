class TexturaHorizonte < Lookup
  alias_attribute :clase, :valor1
  alias_attribute :textura, :valor2
  alias_attribute :suelo, :valor3

  has_many :horizontes, inverse_of: :textura_horizonte
end
