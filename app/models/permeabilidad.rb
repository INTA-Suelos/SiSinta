# Mantiene los valores posibles para Permeabilidad en la ficha de perfiles.
class Permeabilidad < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
