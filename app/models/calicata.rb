# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  after_initialize :preparar
  before_validation :buscar_asociaciones

  scope :series, where(:modal => 'true')

  validate :la_fecha_no_puede_ser_futura
  validates_presence_of :fecha
  validates_uniqueness_of :nombre, :numero, :allow_blank => true
  validates_presence_of :nombre, :if => Proc.new { |c| c.modal? }
  validates_numericality_of :cobertura_vegetal,
                            :greater_than_or_equal_to => 0, :less_than => 101,
                            :allow_nil => true
  validates_associated :ubicacion

  has_many :horizontes,   :dependent => :destroy, :inverse_of => :calicata
  has_many :adjuntos,     :dependent => :destroy, :inverse_of => :calicata
  has_one :capacidad,     :dependent => :destroy, :inverse_of => :calicata
  has_one :ubicacion,     :dependent => :destroy, :inverse_of => :calicata
  has_one :paisaje,       :dependent => :destroy, :inverse_of => :calicata

  # Tablas de lookup. Las asociaciones 1 a 1 pueden ser:
  #   belongs_to => calicata tiene lookup_id
  #   has_one => lookup tiene calicata_id
  # Como los valores de estas tablas son un conjunto definido, se comparten
  # entre todas las calicatas, aunque suene raro un belongs_to acá.
  #
  belongs_to_active_hash :escurrimiento
  belongs_to_active_hash :pendiente
  belongs_to_active_hash :pedregosidad
  belongs_to_active_hash :permeabilidad
  belongs_to_active_hash :relieve
  belongs_to_active_hash :anegamiento
  belongs_to_active_hash :posicion
  belongs_to_active_hash :drenaje
  belongs_to_active_hash :sal
  belongs_to_active_hash :uso_de_la_tierra

  has_many :analisis,         :through => :horizontes

  belongs_to :usuario, :inverse_of => :calicatas
  belongs_to :fase, :inverse_of => :calicatas
  belongs_to :grupo, :inverse_of => :calicatas

  accepts_nested_attributes_for :capacidad, :paisaje, :fase, :ubicacion, :grupo,
                                :limit => 1, :allow_destroy => true
  accepts_nested_attributes_for :horizontes, :analisis, :allow_destroy => true

# == Validaciones

  #
  # Validación para comprobar que no se guarda una calicata que no ha ocurrido.
  #
  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

  #
  # Prepara un hash para que RGeo genere geojson
  #
  def propiedades_publicas
    [:id, :numero, :nombre, :fecha].inject({}) do |hash, atributo|
      hash[atributo] = self.try(atributo)
      hash
    end
  end

  #
  # Devuelve el objeto con la geometría para RGeo
  #
  def geometria
    self.ubicacion.try(:coordenadas)
  end

  def to_s
    self.to_param
  end

  protected

  def preparar
    super(%w{capacidad paisaje ubicacion fase grupo})
  end

  # Arregla la entrada para que no haya objetos repetidos ni se creen vacíos
  def buscar_asociaciones
    super({grupo: 'descripcion', fase: 'nombre'}, true)
  end

end
