class CapacidadSubclase < ActiveRecord::Base
  has_and_belongs_to_many :capacidades
end
