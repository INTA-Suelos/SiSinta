# encoding: utf-8
class MigrarSubclasesDeHumedad < ActiveRecord::Migration

  class Humedad < ActiveRecord::Base
    attr_accessible :subclase_ids, :subclase_id
    serialize :subclase_ids, Array
    guardar_como_arreglo :subclase, SubclaseDeCapacidad
  end

  def up
    say 'Migrando subclase_id a subclase_ids'
    Humedad.where('subclase_id is not ?', nil).each do |h|
      say "id: #{h.id}, subclase_id: #{h.subclase_id}", true
      h.subclase_ids = h.subclase_id
      h.save
    end
  end

  def down
    # No se puede usar un +where is not null+ porque todos tienen un array
    # vacío
    say 'Migrando subclase_ids a subclase_id'
    Humedad.all.reject {|h| h.subclase_ids.empty? }.each do |h|
      say "id: #{h.id}, subclase_ids: #{h.subclase_ids.inspect}.first", true
      h.subclase_id = h.subclase_ids.first
      h.save
    end
  end
end
