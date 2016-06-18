class CreateBusquedas < ActiveRecord::Migration
  def change
    create_table :busquedas do |t|
      t.text :consulta
      t.integer :usuario_id
      t.string :nombre

      t.timestamps null: false
    end
  end
end
