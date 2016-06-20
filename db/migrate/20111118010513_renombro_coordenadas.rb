class RenombroCoordenadas < ActiveRecord::Migration
  def up
    drop_table :ubicaciones
    create_table :ubicaciones do |t|
      t.st_point :coordenadas, srid: 4326
      t.string :descripcion
      t.references :calicata

      t.timestamps null: false
    end

    change_table :ubicaciones do |t|
      t.index :coordenadas, using: :gist
    end
  end

  def down
    drop_table :ubicaciones
    create_table :ubicaciones do |t|
      t.st_point :lat_lon, srid: 4326
      t.string :descripcion
      t.references :calicata

      t.timestamps null: false
    end

    change_table :ubicaciones do |t|
      t.index :lat_lon, using: :gist
    end
  end
end
