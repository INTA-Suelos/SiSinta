class ArregloCalicatas < ActiveRecord::Migration
  def up
    change_table :calicatas do |t|
      t.remove :relieve
      t.remove :posicion
      t.remove :pendiente
      t.remove :escurrimiento
      t.remove :permeabilidad
      t.remove :anegamiento
    end
  end

  def down
    change_table :calicatas do |t|
      t.string :relieve
      t.string :posicion
      t.string :pendiente
      t.string :escurrimiento
      t.string :permeabilidad
      t.integer :anegamiento
    end
  end
end
