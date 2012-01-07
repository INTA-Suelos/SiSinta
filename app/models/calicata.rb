# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base
  after_initialize :preparar
  before_validation :limpiar

  scope :series, where(:modal => 'true')

  validate :la_fecha_no_puede_ser_futura
  validates_presence_of :fecha
  validates_uniqueness_of :nombre, :numero, :allow_blank => true
  validates_presence_of :nombre, :simbolo, :if => Proc.new { |c| c.modal? }
  validates_numericality_of :cobertura_vegetal, :only_integer => true, :allow_nil => true,
                            :greater_than => 0, :less_than => 101

  has_many :horizontes,   :dependent => :destroy, :inverse_of => :calicata
  has_many :fotos,        :dependent => :destroy, :inverse_of => :calicata
  has_one :capacidad,     :dependent => :destroy, :inverse_of => :calicata
  has_one :ubicacion,     :dependent => :destroy, :inverse_of => :calicata
  has_one :paisaje,       :dependent => :destroy, :inverse_of => :calicata

  #
  # Tablas de lookup. Las asociaciones 1 a 1 pueden ser:
  #   belongs_to => calicata tiene lookup_id
  #   has_one => lookup tiene calicata_id
  # Como los valores de estas tablas son un conjunto definido, se comparten
  # entre todas las calicatas, aunque suene raro un belongs_to acá.
  #
  belongs_to :escurrimiento,  :inverse_of => :calicatas
  belongs_to :pendiente,      :inverse_of => :calicatas
  belongs_to :permeabilidad,  :inverse_of => :calicatas
  belongs_to :relieve,        :inverse_of => :calicatas
  belongs_to :anegamiento,    :inverse_of => :calicatas
  belongs_to :posicion,       :inverse_of => :calicatas
  belongs_to :drenaje,        :inverse_of => :calicatas

  has_many :analisis,       :through => :horizontes
  has_many :estructuras,    :through => :horizontes
  has_many :colores,        :through => :horizontes
  has_many :consistencias,  :through => :horizontes
  has_many :limites,        :through => :horizontes

  belongs_to :usuario, :inverse_of => :calicatas
  belongs_to :fase, :inverse_of => :calicatas
  belongs_to :grupo, :inverse_of => :calicatas

  accepts_nested_attributes_for :capacidad, :paisaje, :horizontes, :fase, :ubicacion,
                                :grupo

# == Validaciones

  #
  # Validación para comprobar que no se guarda una calicata que no ha ocurrido.
  #
  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

  def preparar
    super(%w{capacidad paisaje ubicacion fase grupo})
  end

  #
  # Arregla la entrada para que no haya objetos repetidos ni se creen vacíos
  #
  def limpiar
    if self.grupo.try(:descripcion).present? then
      self.grupo = Grupo.find_or_create_by_descripcion self.grupo.descripcion
    else
      self.grupo = nil
    end

    if self.fase.try(:nombre).present? then
      self.fase = Fase.find_or_create_by_nombre self.fase.nombre
    else
      self.fase = nil
    end
  end

end
