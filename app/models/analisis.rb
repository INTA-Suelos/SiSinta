class Analisis < ActiveRecord::Base
  has_one :textura, :dependent => :destroy, :inverse_of => :analisis

  belongs_to :horizonte, :inverse_of => :analisis
  has_one :calicata, :through => :horizonte

  validates_presence_of :horizonte
end
