class AgregarHumedad < ActiveRecord::Migration
  def up
    remove_column :calicatas, :humedad

    create_table :humedades do |t|
      t.integer     :subclase_id
      t.integer     :clase_id
      t.references  :calicata
    end

    add_index :humedades, ["calicata_id"], name: 'index_humedades_on_calicatas', unique: true
  end

  def down
    add_column :calicatas, :humedad, :string
    drop_table :humedades
  end
end
