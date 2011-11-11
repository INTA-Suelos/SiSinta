class CreateCapacidadClases < ActiveRecord::Migration
  def change
    create_table :capacidad_clases do |t|
      t.string :codigo
      t.string :descripcion
      t.string :agrupamiento
    end
  end
end
