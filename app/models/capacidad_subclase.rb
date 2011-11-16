class CapacidadSubclase < ActiveRecord::Base
  has_and_belongs_to_many :capacidades
  has_many :calicatas, :through => :capacidades
end
