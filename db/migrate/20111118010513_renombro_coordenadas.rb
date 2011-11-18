class RenombroCoordenadas < ActiveRecord::Migration
  def up
    change_table :ubicaciones do |t|
      t.rename :lat_lon, :coordenadas
      t.remove_index :lat_lon
      t.index :coordenadas, :name => 'por_coordenadas', :spatial => true
    end
  end

  def down
    change_table :ubicaciones do |t|
      t.rename :coordenadas, :lat_lon
      t.remove_index :coordenadas
      t.index :lat_lon, :spatial => true
    end
  end
end
