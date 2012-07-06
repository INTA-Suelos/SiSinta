# encoding: utf-8
class Rol < ActiveRecord::Base
  has_and_belongs_to_many :usuarios

  # TODO Meter todos estos en method missing
  def self.administrador
    self.find_by_nombre('administrador')
  end

  def self.autorizado
    self.find_by_nombre('autorizado')
  end

  def self.invitado
    self.find_by_nombre('invitado')
  end

  def to_s
    nombre
  end

end
