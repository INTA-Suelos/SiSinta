# Mantiene los valores posibles para Pendiente en la ficha de perfiles.
class Pendiente < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
