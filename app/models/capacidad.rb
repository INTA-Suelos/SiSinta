# encoding: utf-8
class Capacidad < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :calicata, inverse_of: :capacidad
  belongs_to_active_hash :clase_de_capacidad
  serialize :subclase_ids, Array

  validates_presence_of :calicata

  def to_s
    cadena = "#{clase_de_capacidad.try(:to_str)}"
    subclases.each do |sc|
      cadena << ' ' << sc
    end
    return cadena
  end

  def subclases
    SubclaseDeCapacidad.find subclase_ids
  end

  def subclases=(subs)
    Array.wrap(subs).each { |s| subclase_ids << s.id unless subclase_ids.include? s.id }
  end
end
