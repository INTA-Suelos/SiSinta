class Anegamiento < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :anegamiento
end
