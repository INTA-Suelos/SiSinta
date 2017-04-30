# Cargar las subclases para poder generar las entradas en la join table
load 'db/semillas/subclases_de_capacidad.rb'

class Capacidad < ActiveRecord::Base
  has_and_belongs_to_many :subclases, class_name: 'SubclaseDeCapacidad', inverse_of: :capacidades
  serialize :subs_ids, Array
end

class MigrarSubclasesDeCapacidad < ActiveRecord::Migration
  def up
    Capacidad.find_each do |capacidad|
      capacidad.subs_ids.each do |subclase_id|
        capacidad.subclases << SubclaseDeCapacidad.find(subclase_id)
      end
    end
  end

  def down
    Capacidad.find_each { |capacidad| capacidad.subclases.clear }
  end
end
