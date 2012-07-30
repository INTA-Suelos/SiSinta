class PedregosidadConClases < ActiveRecord::Migration
  def up
    create_table :pedregosidades do |t|
      t.integer "subclase_id"
      t.integer "clase_id"
      t.integer "calicata_id"
    end

    remove_column :calicatas, :pedregosidad_id

    add_index :pedregosidades, ["calicata_id"], name: "index_pedregosidades_on_calicatas", unique: true
  end

  def down
    drop_table :pedregosidades

    add_column :calicatas, :pedregosidad_id, :integer

    remove_index :pedregosidades, name: "index_pedregosidades_on_calicatas"
  end
end
