# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base

  validate :la_fecha_no_puede_ser_futura
  validates_presence_of :fecha

  has_many :horizontes,   :dependent => :destroy, :inverse_of => :calicata
  has_many :fotos,        :dependent => :destroy, :inverse_of => :calicata
  has_one :capacidad,     :dependent => :destroy, :inverse_of => :calicata
  has_one :ubicacion,     :dependent => :destroy, :inverse_of => :calicata

  has_one :paisaje,       :inverse_of => :calicata
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
  belongs_to :serie, :inverse_of => :calicatas

  accepts_nested_attributes_for :capacidad, :paisaje, :horizontes, :usuario, :serie, :fase,
                                :escurrimiento, :pendiente, :relieve, :anegamiento, :permeabilidad,
                                :posicion, :drenaje, :ubicacion

# == Validaciones

  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

end
