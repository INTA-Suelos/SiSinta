# encoding: utf-8
class Horizonte < ActiveRecord::Base
  # Nos da belongs_to_active_hash para las asociaciones con modelos estáticos
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Arregla la entrada para que no haya objetos repetidos ni se creen vacíos
  before_save do
    buscar_asociaciones color_seco: 'hvc', color_humedo: 'hvc'
  end

  default_scope order('profundidad_superior ASC')

  has_one :analisis,      dependent: :destroy, inverse_of: :horizonte
  has_one :limite,        dependent: :destroy, inverse_of: :horizonte
  has_one :consistencia,  dependent: :destroy, inverse_of: :horizonte
  has_one :estructura,    dependent: :destroy, inverse_of: :horizonte

  belongs_to :calicata, inverse_of: :horizontes

  belongs_to :color_seco, class_name: 'Color', inverse_of: :horizontes_en_seco,
                          autosave: false
  belongs_to :color_humedo, class_name: 'Color', inverse_of: :horizontes_en_humedo,
                            autosave: false
  belongs_to_active_hash :textura,  inverse_of: :horizontes,
                                    class_name: 'TexturaDeHorizonte'

  accepts_nested_attributes_for :analisis, :limite, :consistencia,
                                :estructura, :textura,
                                limit: 1
  accepts_nested_attributes_for :color_seco, :color_humedo,
                                reject_if: :all_blank

  validates_presence_of :calicata
  validates_inclusion_of  :profundidad_superior, :profundidad_inferior,
                          in: 0..500, allow_nil: true,
                          message: "debe estar entre 0 y 500 cm"

  def rango_profundidad
    unless profundidad_superior.blank? or profundidad_inferior.blank?
      "#{profundidad_superior} - #{profundidad_inferior}"
    end
  end

  def to_s
    self.to_param
  end

  def publico
    calicata.publico
  end

end
