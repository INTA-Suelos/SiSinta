class CreateUbicaciones < ActiveRecord::Migration
  def change
    create_table :ubicaciones do |t|
      t.point :lat_lon, :srid => 4326
      t.string :descripcion

      t.timestamps
    end

    change_table :ubicaciones do |t|
      t.index :lat_lon, :spatial => true
    end
  end
end
