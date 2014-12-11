# encoding: utf-8
class Horizonte < ActiveRecord::Base
  after_create :create_analitico, unless: :analitico_present?

  # TODO sacar los defaults
  default_scope { order('profundidad_superior ASC') }

  has_one :analitico,     dependent: :destroy, inverse_of: :horizonte
  has_one :limite,        dependent: :destroy, inverse_of: :horizonte
  has_one :consistencia,  dependent: :destroy, inverse_of: :horizonte
  has_one :estructura,    dependent: :destroy, inverse_of: :horizonte

  belongs_to :perfil, inverse_of: :horizontes

  belongs_to :color_seco, class_name: 'Color',
              inverse_of: :horizontes_en_seco, validate: false
  belongs_to :color_humedo, class_name: 'Color',
              inverse_of: :horizontes_en_humedo, validate: false
  has_lookup :textura, inverse_of: :horizontes, class_name: 'TexturaDeHorizonte'

  accepts_nested_attributes_for :analitico, :limite, :consistencia,
                                :estructura, :textura,
                                limit: 1
  accepts_nested_attributes_for :color_seco, :color_humedo,
                                reject_if: :all_blank

  validates_presence_of :perfil
  validates_inclusion_of  :profundidad_superior, :profundidad_inferior,
                          in: 0..500, allow_nil: true,
                          message: "debe estar entre 0 y 500 cm"

  delegate :publico, :usuario, :usuario_id, to: :perfil
  delegate :present?, to: :analitico, prefix: true

  # Se crea un color si no existe ya
  def autosave_associated_records_for_color_seco
    if color_seco.try(:hvc?)
      self.color_seco = Color.find_or_create_by(hvc: color_seco.hvc)
    end
  end

  # Se crea un color si no existe ya
  def autosave_associated_records_for_color_humedo
    if color_humedo.try(:hvc?)
      self.color_humedo = Color.find_or_create_by(hvc: color_humedo.hvc)
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

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id']
  end
end
