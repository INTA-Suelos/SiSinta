class CambiarPrecisionEnAnaliticos < ActiveRecord::Migration
  def up
    change_table :analiticos do |t|
      t.change  "materia_organica_c",  :decimal, :precision => 5, :scale => 2
      t.change  "materia_organica_n",  :decimal, :precision => 6, :scale => 3
      t.change  "humedad",             :decimal, :precision => 5, :scale => 2
      t.change  "arcilla",             :decimal, :precision => 5, :scale => 2
      t.change  "limo_2_20",           :decimal, :precision => 5, :scale => 2
      t.change  "limo_2_50",           :decimal, :precision => 5, :scale => 2
      t.change  "arena_muy_fina",      :decimal, :precision => 5, :scale => 2
      t.change  "arena_fina",          :decimal, :precision => 5, :scale => 2
      t.change  "arena_media",         :decimal, :precision => 5, :scale => 2
      t.change  "arena_gruesa",        :decimal, :precision => 5, :scale => 2
      t.change  "arena_muy_gruesa",    :decimal, :precision => 5, :scale => 2
      t.change  "ca_co3",              :decimal, :precision => 5, :scale => 2
      t.change  "agua_15_atm",         :decimal, :precision => 5, :scale => 2
      t.change  "agua_util",           :decimal, :precision => 5, :scale => 2
      t.change  "saturacion_t",        :decimal, :precision => 5, :scale => 2
      t.change  "saturacion_s_h",      :decimal, :precision => 5, :scale => 2
      t.change  "agua_3_atm",          :decimal, :precision => 5, :scale => 2
    end
  end

  def down
    change_table :analiticos do |t|
      t.change  "materia_organica_c",  :decimal, :precision => 4, :scale => 2
      t.change  "materia_organica_n",  :decimal, :precision => 4, :scale => 2
      t.change  "humedad",             :decimal, :precision => 4, :scale => 2
      t.change  "arcilla",             :decimal, :precision => 4, :scale => 2
      t.change  "limo_2_20",           :decimal, :precision => 4, :scale => 2
      t.change  "limo_2_50",           :decimal, :precision => 4, :scale => 2
      t.change  "arena_muy_fina",      :decimal, :precision => 4, :scale => 2
      t.change  "arena_fina",          :decimal, :precision => 4, :scale => 2
      t.change  "arena_media",         :decimal, :precision => 4, :scale => 2
      t.change  "arena_gruesa",        :decimal, :precision => 4, :scale => 2
      t.change  "arena_muy_gruesa",    :decimal, :precision => 4, :scale => 2
      t.change  "ca_co3",              :decimal, :precision => 4, :scale => 2
      t.change  "agua_15_atm",         :decimal, :precision => 4, :scale => 2
      t.change  "agua_util",           :decimal, :precision => 4, :scale => 2
      t.change  "saturacion_t",        :decimal, :precision => 4, :scale => 2
      t.change  "saturacion_s_h",      :decimal, :precision => 4, :scale => 2
      t.change  "agua_3_atm",          :decimal, :precision => 4, :scale => 2
    end
  end
end
