class ArreglarAnalisis < ActiveRecord::Migration
  def up
    change_table :analisis do |t|
      t.remove :carbono, :nitrogeno

      t.change :materia_organica_c, :decimal, precision: 3, scale: 2
      t.change :materia_organica_n, :decimal, precision: 3, scale: 2

      t.decimal :ca_co3, precision: 3, scale: 2
      t.decimal :agua_ret, precision: 3, scale: 2
      t.decimal :agua_util, precision: 3, scale: 2
      t.decimal :conductividad
      t.decimal :h
      t.decimal :saturacion_t, precision: 3, scale: 2
      t.decimal :saturacion_s_h, precision: 3, scale: 2
      t.decimal :peso_especifico_aparente
    end
  end

  def down
    change_table :analisis do |t|
      t.decimal  "carbono",            :precision => 4, :scale => 2
      t.decimal  "nitrogeno",          :precision => 4, :scale => 3

      t.change :materia_organica_c, :float
      t.change :materia_organica_n, :float

      t.remove :ca_co3
      t.remove :agua_ret
      t.remove :agua_util
      t.remove :conductividad
      t.remove :h
      t.remove :saturacion_t
      t.remove :saturacion_s_h
      t.remove :peso_especifico_aparente
    end
  end
end
