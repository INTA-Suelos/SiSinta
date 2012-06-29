class TexturaDeHorizonte < Lookup
  has_many :horizontes, inverse_of: :textura_de_horizonte
end
