# Mantiene los valores posibles para Anegamiento en la ficha de perfiles.
class Anegamiento < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
