# encoding: utf-8
class Horizonte < ActiveRecord::Base
  # Nos da belongs_to_active_hash para las asociaciones con modelos estáticos
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_accessible :profundidad_superior, :color_seco, :color_humedo, :limite,
                  :consistencia, :estructura, :tipo, :profundidad_inferior,
                  :limite_attributes, :color_seco_attributes,
                  :color_humedo_attributes, :textura_id,
                  :estructura_attributes, :consistencia_attributes, :ph, :co3,
                  :concreciones, :barnices, :moteados, :humedad, :raices,
                  :formaciones_especiales

  after_create :create_analitico

  default_scope order('profundidad_superior ASC')

  has_one :analitico,     dependent: :destroy, inverse_of: :horizonte
  has_one :limite,        dependent: :destroy, inverse_of: :horizonte
  has_one :consistencia,  dependent: :destroy, inverse_of: :horizonte
  has_one :estructura,    dependent: :destroy, inverse_of: :horizonte

  belongs_to :perfil, inverse_of: :horizontes

  belongs_to :color_seco, class_name: 'Color',
              inverse_of: :horizontes_en_seco, validate: false
  belongs_to :color_humedo, class_name: 'Color',
              inverse_of: :horizontes_en_humedo, validate: false
  belongs_to_active_hash :textura,  inverse_of: :horizontes,
                                    class_name: 'TexturaDeHorizonte'

  accepts_nested_attributes_for :analitico, :limite, :consistencia,
                                :estructura, :textura,
                                limit: 1
  accepts_nested_attributes_for :color_seco, :color_humedo,
                                reject_if: :all_blank

  validates_presence_of :perfil
  validates_inclusion_of  :profundidad_superior, :profundidad_inferior,
                          in: 0..500, allow_nil: true,
                          message: "debe estar entre 0 y 500 cm"

  delegate :publico, to: :perfil

  # Se crea un color si no existe ya
  def autosave_associated_records_for_color_seco
    if color_seco.try(:hvc?)
      self.color_seco = Color.find_or_create_by_hvc(color_seco.hvc)
    end
  end

  # Se crea un color si no existe ya
  def autosave_associated_records_for_color_humedo
    if color_humedo.try(:hvc?)
      self.color_humedo = Color.find_or_create_by_hvc(color_humedo.hvc)
    end
  end

  def rango_profundidad
    if profundidad_superior? and profundidad_inferior?
      "#{profundidad_superior} - #{profundidad_inferior}"
    end
  end

  def to_s
    self.to_param
  end

end
