class Relieve < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :relieve
end
