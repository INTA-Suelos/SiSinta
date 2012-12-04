class Serie < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :simbolo

  has_many :perfiles
end
