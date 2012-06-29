class Escurrimiento < Lookup
  has_many :calicatas, :inverse_of => :escurrimiento
end
