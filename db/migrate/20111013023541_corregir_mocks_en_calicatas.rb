class CorregirMocksEnCalicatas < ActiveRecord::Migration
  def up
    change_table(:calicatas) do |t|
      t.remove :referencia, :numero_fotos, :unidad_geomorfologica, :napa
      t.remove :modal, :fecha, :desarrollo, :paisaje, :limitaciones

      t.boolean "modal", :default => false
      t.date    "fecha", :null => false

      t.rename :uniforme, :humedad_uniforme
    end
  end

  def down
    change_table(:calicatas) do |t|
      t.string :referencia
      t.integer :numero_fotos
      t.string :unidad_geomorfologica
      t.string :napa
      t.integer :desarrollo
      t.string :paisaje
      t.string :limitaciones
      t.rename :humedad_uniforme, :uniforme
    end
  end
end
