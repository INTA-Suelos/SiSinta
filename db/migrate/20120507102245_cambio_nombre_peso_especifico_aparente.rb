class CambioNombrePesoEspecificoAparente < ActiveRecord::Migration
  def change
    rename_column :analisis, :peso_especifico_aparente, :densidad_aparente
  end
end
