# encoding: utf-8
class Grupo < ActiveRecord::Base
  attr_accessible :codigo, :descripcion, :perfiles_attributes

  has_many :perfiles, inverse_of: :grupo

  validates_uniqueness_of :codigo, allow_blank: true
  validates_uniqueness_of :descripcion
  validates_presence_of :descripcion

  accepts_nested_attributes_for :perfiles
end
