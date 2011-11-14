class Drenaje < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :drenaje
end
