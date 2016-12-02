class CreateIgnProvincias < ActiveRecord::Migration
  def up
    create_table 'ign_provincias', primary_key: 'gid', force: :cascade do |t|
      t.string    'objeto', limit: 50
      t.string    'fna',    limit: 150
      t.string    'gna',    limit: 50
      t.string    'nam',    limit: 100
      t.string    'sag',    limit: 50
      t.geography 'geog',   limit: { srid: 4326, type: 'multi_polygon', has_z: true, has_m: true, geographic: true }
    end

    add_index 'ign_provincias', ['geog'], name: 'ign_provincias_geog_idx', using: :gist
  end

  def down
    drop_table :ign_provincias
  end
end
