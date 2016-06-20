class CreateUbicaciones < ActiveRecord::Migration
  def change
    create_table :ubicaciones do |t|
      t.st_point :lat_lon, srid: 4326
      t.string :descripcion

      t.timestamps null: false
    end

    change_table :ubicaciones do |t|
      t.index :lat_lon, using: :gist
    end
  end
end
