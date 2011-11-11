# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base
  @@valores_escurrimiento = ['estancado','muy lento','lento','medio','rápido','muy rápido']
  @@valores_pendiente = ['0 - 1%','1 - 3%','3 - 10%','10 - 25%','25 - 45%','45%']

  validate :la_fecha_no_puede_ser_futura
  validates :escurrimiento, :inclusion => { :in => @@valores_escurrimiento,
    :message => "%{value} no es un grado de escurrimiento válido" }
  validates :pendiente, :inclusion => { :in => @@valores_pendiente,
    :message => "%{value} no es una clase de pendiente válida" }

  has_many :horizontes,   :dependent => :destroy, :inverse_of => :calicata
  has_many :fotos,        :dependent => :destroy, :inverse_of => :calicata
  has_one :clasificacion, :dependent => :destroy, :inverse_of => :calicata
  has_one :capacidad,   :dependent => :destroy, :inverse_of => :calicata
  has_one :paisaje,       :dependent => :destroy, :inverse_of => :calicata

  has_many :analisis,       :through => :horizontes
  has_many :estructuras,    :through => :horizontes
  has_many :colores,        :through => :horizontes
  has_many :consistencias,  :through => :horizontes
  has_many :limites,        :through => :horizontes

  accepts_nested_attributes_for :clasificacion, :paisaje, :horizontes,
                                :fotos

# == Validaciones

  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

end
