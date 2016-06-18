class CreateCalicatas < ActiveRecord::Migration
  def change
    create_table :calicatas do |t|
      t.date :fecha
      t.string :numero
      t.boolean :modal
      t.integer :drenaje
      t.integer :escurrimiento
      t.integer :permeabilidad
      t.string :napa
      t.float :profundidad_napa
      t.integer :anegamiento
      t.boolean :uniforme
      t.decimal :cobertura_vegetal
      t.string :uso_tierra
      t.string :vegetacion
      t.integer :desarrollo
      t.string :posicion
      t.references :serie

      t.timestamps null: false
    end
  end
end
