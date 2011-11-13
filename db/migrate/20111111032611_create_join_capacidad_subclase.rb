class CreateJoinCapacidadSubclase < ActiveRecord::Migration
  def up
    # Por alguna razón el :force => true lo hacía fallar
    create_table "capacidad_subclase_capacidad", :id => false do |t|
      t.column "capacidad_id", :integer, :null => false
      t.column "capacidad_subclase_id", :integer, :null => false
    end
  end

  def down
    drop_table "capacidad_subclase_capacidad"
  end
end
