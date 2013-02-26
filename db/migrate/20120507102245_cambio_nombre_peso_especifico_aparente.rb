class CambioNombrePesoEspecificoAparente < ActiveRecord::Migration
  def change
    rename_column :analiticos, :peso_especifico_aparente, :densidad_aparente
  end
end
