class UsoTierra < Lookup
  has_many :calicatas, :inverse_of => :uso_tierra
end
