class Serie < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :serie

  validates_uniqueness_of :nombre, :simbolo
  validates_presence_of :nombre
end
