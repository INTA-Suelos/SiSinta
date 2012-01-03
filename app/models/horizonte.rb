# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  has_one :analisis,      :dependent => :destroy, :inverse_of => :horizonte
  has_one :color,         :dependent => :destroy, :inverse_of => :horizonte
  has_one :limite,        :dependent => :destroy, :inverse_of => :horizonte
  has_one :consistencia,  :dependent => :destroy, :inverse_of => :horizonte
  has_one :estructura,    :dependent => :destroy, :inverse_of => :horizonte

  has_many :texturas, :through => :analisis

  belongs_to :calicata, :inverse_of => :horizontes

  accepts_nested_attributes_for :analisis, :color, :limite, :consistencia,
                                :estructura

  validates_presence_of :calicata

  #
  # Construye los objetos asociados al modelo, para usar con el +FormHelper+, si es que no
  # existen ya.
  #
  # * *Args*    :
  #   - +calicata+ -> la instancia de calicata sobre la que construir las asociaciones
  # * *Returns* :
  #   - el modelo con las asociaciones preparadas
  #
  def preparar
    %w{color limite consistencia estructura analisis}.each do |asociacion|
      self.send("build_#{asociacion}") if self.send(asociacion).nil?
    end
    return self
  end

end
