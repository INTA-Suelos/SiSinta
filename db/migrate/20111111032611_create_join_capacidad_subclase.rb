class CreateJoinCapacidadSubclase < ActiveRecord::Migration
  def up
    create_table :capacidad_subclases_capacidades, :id => false, :force => true do |t|
      t.references :capacidad
      t.references :capacidad_subclase
    end
  end

  def down
    drop_table :capacidad_subclases_capacidades
  end
end
