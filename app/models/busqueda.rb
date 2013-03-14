# encoding: utf-8
class Busqueda < ActiveRecord::Base
  attr_accessible :consulta, :nombre, :usuario_id

  store :consulta

  belongs_to :usuario
end
