# encoding: utf-8
class Grupo < ActiveRecord::Base
  has_many :perfiles

  validates_uniqueness_of :codigo, allow_blank: true
  validates_uniqueness_of :descripcion
  validates_presence_of :descripcion

  accepts_nested_attributes_for :perfiles
end
