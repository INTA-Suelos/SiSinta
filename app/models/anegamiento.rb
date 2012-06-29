class Anegamiento < Lookup
  has_many :calicatas, :inverse_of => :anegamiento
end
