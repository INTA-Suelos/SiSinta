# encoding: utf-8
class Fase < ActiveRecord::Base
  has_many :perfiles

  validates_uniqueness_of :codigo, allow_blank: true, allow_nil: true
  validates_uniqueness_of :nombre
  validates_presence_of :nombre

  accepts_nested_attributes_for :perfiles
end
