# Cargar las subclases para poder generar las entradas en la join table
load 'db/semillas/subclases_de_humedad.rb'

class Humedad < ApplicationRecord
  has_and_belongs_to_many :subclases, class_name: 'SubclaseDeHumedad', inverse_of: :humedades
  serialize :subs_ids, Array
end

class MigrarSubclasesDeHumedadAgain < ActiveRecord::Migration
  def up
    Humedad.find_each do |humedad|
      humedad.subs_ids.each do |subclase_id|
        humedad.subclases << SubclaseDeHumedad.find(subclase_id)
      end
    end
  end

  def down
    Humedad.find_each { |humedad| humedad.subclases.clear }
  end
end
