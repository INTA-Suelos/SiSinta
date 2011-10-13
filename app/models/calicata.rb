# -*- encoding : utf-8 -*-
class Calicata < ActiveRecord::Base
  validate :la_fecha_no_puede_ser_futura
  validates :escurrimiento, :inclusion => { :in => @@valores_escurriemiento,
    :message => "%{value} no es un grado de escurrimiento válido" }
  validates :pendiente, :inclusion => { :in => @@valores_pendiente,
    :message => "%{value} no es una clase de pendiente válida" }

  has_many :horizontes,     :dependent => :destroy
  has_many :fotos,          :dependent => :destroy

  has_many :analisis,       :through => :horizontes
  has_many :estructuras,    :through => :horizontes
  has_many :colores,        :through => :horizontes
  has_many :consistencias,  :through => :horizontes
  has_many :limites,        :through => :horizontes

  has_one :clasificacion,   :dependent => :destroy
  has_one :paisaje,         :dependent => :destroy
# == Validaciones

  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end

  @@valores_escurrimiento = ['estancado','muy lento','lento','medio','rápido','muy rápido']
  @@valores_pendiente = ['0 - 1%','1 - 3%','3 - 10%','10 - 25%','25 - 45%','45%']
end
