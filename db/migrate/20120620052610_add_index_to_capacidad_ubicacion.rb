class AddIndexToCapacidadUbicacion < ActiveRecord::Migration
  def up
    add_index :capacidades, ["calicata_id"], :name => "index_capacidades_on_calicatas", :unique => true
    add_index :ubicaciones, ["calicata_id"], :name => "index_ubicaciones_on_nombre", :unique => true
  end

  def down
    remove_index :capacidades, ["calicata_id"]
    remove_index :ubicaciones, ["calicata_id"]
  end
end
