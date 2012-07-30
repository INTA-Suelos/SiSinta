class ErosionConClases < ActiveRecord::Migration
  def up
    create_table :erosiones do |t|
      t.integer "subclase_id"
      t.integer "clase_id"
      t.integer "calicata_id"
    end

    remove_column :calicatas, :erosion

    add_index :erosiones, ["calicata_id"], name: "index_erosiones_on_calicatas", unique: true
  end

  def down
    drop_table :erosiones

    add_column :calicatas, :erosion, :string

    remove_index :erosiones, name: "index_erosiones_on_calicatas"
  end
end
