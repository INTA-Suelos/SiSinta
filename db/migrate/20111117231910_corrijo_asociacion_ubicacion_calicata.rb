class CorrijoAsociacionUbicacionCalicata < ActiveRecord::Migration
  def up
    remove_column :calicatas, :ubicacion_id
    add_column :ubicaciones, :calicata_id, :integer
  end

  def down
    add_column :calicatas, :ubicacion_id, :integer
    remove_column :ubicaciones, :calicata_id
  end
end
