class CreateSubclaseDeCapacidad < ActiveRecord::Migration
  def change
    create_table :subclases_de_capacidad do |t|
      t.string :codigo, null: false
      t.string :descripcion
    end
  end
end
