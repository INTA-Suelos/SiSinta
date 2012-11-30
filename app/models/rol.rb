# encoding: utf-8
class Rol < ActiveRecord::Base
  has_and_belongs_to_many :usuarios
  belongs_to :resource, :polymorphic => true

  alias_attribute :nombre, :name

  scopify

  # TODO Meter todos estos en method missing
  def self.administrador
    self.find_by_name('administrador')
  end

  def self.autorizado
    self.find_by_name('autorizado')
  end

  def self.invitado
    self.find_by_name('invitado')
  end

  def to_s
    nombre
  end

end
