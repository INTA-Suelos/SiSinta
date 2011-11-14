class Posicion < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :calicatas
end
