class RenombroCoordenadas < ActiveRecord::Migration
  def up
    drop_table :ubicaciones

    create_table :ubicaciones do |t|
      t.point :coordenadas, :srid => 4326
      t.string :descripcion
      t.references :calicata

      t.timestamps
    end

    change_table :ubicaciones do |t|
      t.index :coordenadas, :spatial => true
    end

  end

  def down
    drop_table :ubicaciones
    create_table :ubicaciones do |t|
      t.point :lat_lon, :srid => 4326
      t.string :descripcion
      t.references :calicata

      t.timestamps
    end

    change_table :ubicaciones do |t|
      t.index :lat_lon, :spatial => true
    end
  end
end
