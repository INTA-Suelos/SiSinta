class Grupo < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :grupo

  validates_uniqueness_of :codigo, :allow_blank => true
  validates_uniqueness_of :descripcion
  validates_presence_of :descripcion

  def to_s
    self.try(:descripcion).to_s
  end
end
