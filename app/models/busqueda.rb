# encoding: utf-8
class Busqueda < ActiveRecord::Base
  attr_accessible :consulta, :nombre, :usuario, :publico

  store :consulta

  belongs_to :usuario

  validates_uniqueness_of :nombre
  validates_presence_of :nombre

  # TODO renombrar +publico+ en todos los modelos a un nombre sin género
  # (+accesible+, o algo así)
  alias_attribute :publica, :publico

  scope :publicas, where(publico: 'true')
end
