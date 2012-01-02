class Grupo < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :grupo
end
