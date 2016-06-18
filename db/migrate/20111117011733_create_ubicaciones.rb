class CreateUbicaciones < ActiveRecord::Migration
  def change
    create_table :ubicaciones do |t|
      # `geographic: true` creates a PostGIS geography column for
      # longitude/latitude data over a spheroidal domain, also implies :srid
      # set to 4326.
      t.st_point :lat_lon, srid: 4326, geographic: true
      t.string :descripcion

      t.timestamps null: false
    end

    change_table :ubicaciones do |t|
      t.index :lat_lon, using: :gist
    end
  end
end
