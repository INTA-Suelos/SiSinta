# -*- encoding : utf-8 -*-
class Horizonte < ActiveRecord::Base
  after_initialize :preparar
  before_validation :buscar_asociaciones

  has_one :analisis,      :dependent => :destroy, :inverse_of => :horizonte
  has_one :limite,        :dependent => :destroy, :inverse_of => :horizonte
  has_one :consistencia,  :dependent => :destroy, :inverse_of => :horizonte
  has_one :estructura,    :dependent => :destroy, :inverse_of => :horizonte

  has_many :texturas, :through => :analisis

  belongs_to :calicata, :inverse_of => :horizontes

  belongs_to :color_seco, class_name: 'Color', inverse_of: :horizontes_en_seco,
                          autosave: false
  belongs_to :color_humedo, class_name: 'Color', inverse_of: :horizontes_en_humedo,
                            autosave: false

  accepts_nested_attributes_for :analisis, :limite, :consistencia, :color_seco,
                                :color_humedo, :estructura, :limit => 1

  validates_presence_of :calicata

  def rango_profundidad
    unless profundidad_superior.blank? or profundidad_inferior.blank?
      "#{profundidad_superior} - #{profundidad_inferior}"
    end
  end

  protected

  def preparar
    super(%w{color_seco color_humedo limite consistencia estructura analisis})
  end

  # Arregla la entrada para que no haya objetos repetidos ni se creen vacíos
  def buscar_asociaciones
    super({color_seco: 'hvc', color_humedo: 'hvc'})
  end

end
