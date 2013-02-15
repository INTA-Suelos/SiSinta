# encoding: utf-8
class Fase < ActiveRecord::Base
  attr_accessible :nombre, :codigo

  has_many :perfiles, inverse_of: :fase

  validates_uniqueness_of :codigo, allow_blank: true, allow_nil: true
  validates_uniqueness_of :nombre
  validates_presence_of :nombre
end
