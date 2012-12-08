# encoding: utf-8
class Perfil < ActiveRecord::Base
  attr_accessible :fecha, :numero, :drenaje_id, :profundidad_napa,
                  :cobertura_vegetal, :posicion_id, :pendiente_id,
                  :escurrimiento_id, :anegamiento_id, :grupo_id, :sal_id,
                  :uso_de_la_tierra_id, :material_original, :esquema,
                  :fase_id, :modal, :observaciones, :publico, :relieve_id,
                  :ubicacion_attributes, :paisaje_attributes, :fase_attributes,
                  :permeabilidad_id, :vegetacion_o_cultivos, :grupo_attributes,
                  :capacidad_attributes, :humedad_attributes, :pedregosidad_attributes,
                  :erosion_attributes, :etiquetas, :reconocedores

  # Nos da belongs_to_active_hash para las asociaciones con modelos estáticos
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_taggable :etiquetas
  attr_taggable :reconocedores

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'

  before_validation do
    buscar_asociaciones({ grupo: 'descripcion', fase: 'nombre' }, true)
  end

  scope :modales, where(modal: 'true')
  scope :index,   joins(:ubicacion)
                  .select('perfiles.fecha, perfiles.nombre,
                           ubicacion.descripcion as ubicacion,
                           perfiles.numero, perfiles.modal')

  validate :fecha_no_puede_ser_futura, :numero_es_unico_dentro_de_una_serie
  validates_presence_of :fecha
  validates_presence_of :numero
  validates_numericality_of :cobertura_vegetal,
                            greater_than_or_equal_to: 0, less_than: 101,
                            allow_nil: true

  has_many :horizontes,   dependent: :destroy, inverse_of: :perfil
  has_many :adjuntos,     dependent: :destroy, inverse_of: :perfil
  has_one :capacidad,     dependent: :destroy, inverse_of: :perfil
  has_one :ubicacion,     dependent: :destroy, inverse_of: :perfil
  has_one :paisaje,       dependent: :destroy, inverse_of: :perfil
  has_one :humedad,       dependent: :destroy, inverse_of: :perfil
  has_one :erosion,       dependent: :destroy, inverse_of: :perfil
  has_one :pedregosidad,  dependent: :destroy, inverse_of: :perfil

  # Tablas de lookup. Las asociaciones 1 a 1 pueden ser:
  #   belongs_to => perfil tiene lookup_id
  #   has_one => lookup tiene perfil_id
  # Como los valores de estas tablas son un conjunto definido, se comparten
  # entre todos los perfiles, aunque suene raro un belongs_to acá.
  belongs_to_active_hash :escurrimiento
  belongs_to_active_hash :pendiente
  belongs_to_active_hash :permeabilidad
  belongs_to_active_hash :relieve
  belongs_to_active_hash :anegamiento
  belongs_to_active_hash :posicion
  belongs_to_active_hash :drenaje
  belongs_to_active_hash :sal
  belongs_to_active_hash :uso_de_la_tierra

  has_many :analisis, through: :horizontes

  belongs_to :usuario,  inverse_of: :perfiles
  belongs_to :fase,     inverse_of: :perfiles
  belongs_to :grupo,    inverse_of: :perfiles
  belongs_to :serie,    inverse_of: :perfiles

  has_and_belongs_to_many :proyectos

  accepts_nested_attributes_for :capacidad, :paisaje, :ubicacion, :pedregosidad,
                                :humedad, :erosion,
                                limit: 1, allow_destroy: true
  accepts_nested_attributes_for :grupo, :fase, :serie, limit: 1, reject_if: :all_blank
  accepts_nested_attributes_for :horizontes, :analisis, allow_destroy: true

  delegate :nombre,   to: :serie, allow_nil: true
  delegate :simbolo,  to: :serie, allow_nil: true

  # Validación para comprobar que no se guarda un perfil que aún no ha ocurrido.
  def fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, :future)
    end
  end

  # TODO Comprueba que numero sea único dentro de una serie
  def numero_es_unico_dentro_de_una_serie
  end

  # Prepara un hash para que RGeo genere geojson
  def propiedades_publicas
    [:id, :numero, :nombre, :fecha].inject({}) do |hash, atributo|
      hash[atributo] = self.try(atributo)
      hash
    end
  end

  # Devuelve el objeto con la geometría para RGeo
  #
  def geometria
    self.ubicacion.try(:coordenadas)
  end

  def to_s
    self.to_param
  end

end
