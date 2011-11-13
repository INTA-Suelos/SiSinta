class CreateJoinCapacidadSubclase < ActiveRecord::Migration
  def up
    create_table "capacidad_subclases_capacidades", :id => false, :force => true do |t|
      t.column "capacidad_id", :integer
      t.column "capacidad_subclase_id", :integer
    end
  end

  def down
    drop_table "capacidad_subclases_capacidades"
  end
end
