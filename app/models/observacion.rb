# -*- encoding : utf-8 -*-
class Observacion < ActiveRecord::Base
  validate :la_fecha_no_puede_ser_futura

  has_many :horizontes, :dependent => :destroy
  has_many :analisis, :through => :horizontes

# == Validaciones

  def la_fecha_no_puede_ser_futura
    if !fecha.blank? and fecha > Date.today
      errors.add(:fecha, I18n.t("error por fecha futura"))
    end
  end
end
