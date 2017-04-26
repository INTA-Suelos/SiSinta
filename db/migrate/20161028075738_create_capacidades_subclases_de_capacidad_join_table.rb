class CreateCapacidadesSubclasesDeCapacidadJoinTable < ActiveRecord::Migration
  def change
    create_join_table :capacidades, :subclases_de_capacidad do |t|
      t.index [:subclase_de_capacidad_id, :capacidad_id], unique: true, name: 'subclases_capacidades'
    end
  end
end
