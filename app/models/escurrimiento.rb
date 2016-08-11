# Mantiene los valores posibles para Escurrimiento en la ficha de perfiles.
class Escurrimiento < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
