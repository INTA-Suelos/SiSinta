class CreateCapacidadSubclases < ActiveRecord::Migration
  def change
    create_table :capacidad_subclases do |t|
      t.string :codigo
      t.string :descripcion
    end
  end
end
