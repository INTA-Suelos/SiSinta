class AddSubclaseEnCapacidad < ActiveRecord::Migration
  def up
    drop_table :capacidades_subclases_de_capacidad

    add_column :capacidades, :subclase_ids, :text
  end

  def down
    create_table "capacidades_subclases_de_capacidad", :id => false, :force => true do |t|
      t.integer "capacidad_id"
      t.integer "subclase_de_capacidad_id"
    end

    remove_column :capacidades, :subclase_ids
  end
end
