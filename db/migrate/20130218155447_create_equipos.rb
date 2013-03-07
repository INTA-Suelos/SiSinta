class CreateEquipos < ActiveRecord::Migration
  def change
    create_table :equipos do |t|
      t.string :nombre, null: false

      t.timestamps
    end

    add_index "equipos", ["nombre"],
      name: "index_equipos_on_nombre", unique: true
  end
end
