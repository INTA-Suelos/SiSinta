class RenombroCoordenadas < ActiveRecord::Migration
  def up
    rename_column :ubicaciones, :lat_lon, :coordenadas
  end

  def down
    rename_column :ubicaciones, :coordenadas, :lat_lon
  end
end
