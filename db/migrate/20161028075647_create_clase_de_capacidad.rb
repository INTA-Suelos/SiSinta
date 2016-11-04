class CreateClaseDeCapacidad < ActiveRecord::Migration
  def change
    create_table :clases_de_capacidad do |t|
      t.string :codigo, null: false
      t.string :descripcion
      t.string :categoria
    end
  end
end
