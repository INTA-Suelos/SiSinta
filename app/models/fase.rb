class Fase < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :fase

  validates_uniqueness_of :codigo, :allow_blank => true, :allow_nil => true
  validates_uniqueness_of :nombre
  validates_presence_of :nombre

  def to_s
    nombre
  end
end
