class Pendiente < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :pendiente
end
