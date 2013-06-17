# encoding: utf-8
class Busqueda < ActiveRecord::Base
  attr_accessible :consulta, :nombre, :usuario

  store :consulta

  belongs_to :usuario

  validates_uniqueness_of :nombre
  validates_presence_of :nombre
end
