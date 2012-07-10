# encoding: utf-8
class TexturaDeHorizonte < Lookup
  has_many :horizontes, inverse_of: :textura_de_horizonte

  def to_str
    clase
  end

end
