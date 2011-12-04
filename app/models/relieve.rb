class Relieve < Lookup
  has_many :calicatas, :inverse_of => :relieve
end
