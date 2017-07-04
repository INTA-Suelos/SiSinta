class CreateProcesamientosPerfilesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :procesamientos, :perfiles do |t|
      t.index [:perfil_id, :procesamiento_id], unique: true
    end
  end
end
