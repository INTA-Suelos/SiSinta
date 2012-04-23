class Analisis < ActiveRecord::Base
  has_one :textura, :dependent => :destroy, :inverse_of => :analisis

  belongs_to :horizonte, :inverse_of => :analisis
  has_one :calicata, :through => :horizonte

  validates_presence_of :horizonte

  def materia_organica_cn
    (materia_organica_c/materia_organica_n).round
  end
end
