class CambioCalicataPorPerfil < ActiveRecord::Migration
  def up
    rename_column :adjuntos, :calicata_id, :perfil_id
    rename_column :capacidades, :calicata_id, :perfil_id
    rename_column :erosiones, :calicata_id, :perfil_id
    rename_column :horizontes, :calicata_id, :perfil_id
    rename_column :humedades, :calicata_id, :perfil_id
    rename_column :paisajes, :calicata_id, :perfil_id
    rename_column :pedregosidades, :calicata_id, :perfil_id
    rename_column :ubicaciones, :calicata_id, :perfil_id

    rename_table :calicatas, :perfiles

    remove_index :capacidades, name: 'index_capacidades_on_calicatas'
    remove_index :humedades, name: 'index_humedades_on_calicatas'
    remove_index :paisajes, name: 'index_paisajes_on_calicatas'
    remove_index :pedregosidades, name: 'index_pedregosidades_on_calicatas'
    remove_index :ubicaciones, name: 'index_ubicaciones_on_nombre'
    remove_index :erosiones, name: 'index_erosiones_on_calicatas'
  end

  def down
    rename_column :adjuntos, :perfil_id, :calicata_id
    rename_column :capacidades, :perfil_id, :calicata_id
    rename_column :erosiones, :perfil_id, :calicata_id
    rename_column :horizontes, :perfil_id, :calicata_id
    rename_column :humedades, :perfil_id, :calicata_id
    rename_column :paisajes, :perfil_id, :calicata_id
    rename_column :pedregosidades, :perfil_id, :calicata_id
    rename_column :ubicaciones, :perfil_id, :calicata_id

    rename_table :perfiles, :calicatas
  
    add_index "capacidades", ["calicata_id"], :name => "index_capacidades_on_calicatas", :unique => true
    add_index "erosiones", ["calicata_id"], :name => "index_erosiones_on_calicatas", :unique => true
    add_index "humedades", ["calicata_id"], :name => "index_humedades_on_calicatas", :unique => true
    add_index "paisajes", ["calicata_id"], :name => "index_paisajes_on_calicatas", :unique => true
    add_index "pedregosidades", ["calicata_id"], :name => "index_pedregosidades_on_calicatas", :unique => true
    add_index "ubicaciones", ["calicata_id"], :name => "index_ubicaciones_on_nombre", :unique => true
  end
end
