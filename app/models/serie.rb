class Serie < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :serie
end
