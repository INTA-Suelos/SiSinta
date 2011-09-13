class CreateHorizons < ActiveRecord::Migration
  def change
    create_table :horizons do |t|
      t.integer :profundidad
      t.string :color_seco
      t.string :color_humedo
      t.string :tipo
      t.string :clase
      t.string :grado
      t.float :ph
      t.string :textura
      t.integer :orden
      t.string :humedad

      t.timestamps
    end
  end
end
