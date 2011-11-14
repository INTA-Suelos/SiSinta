class AgregarLlavesEnCalicatas < ActiveRecord::Migration
  def change
    change_table :calicatas do |t|
      t.references :relieve, :posicion, :pendiente
      t.references :escurrimiento, :permeabilidad, :anegamiento
    end
  end
end
