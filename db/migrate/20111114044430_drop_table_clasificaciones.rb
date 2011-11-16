class DropTableClasificaciones < ActiveRecord::Migration
  def up
    drop_table :clasificaciones
  end

  def down
    create_table "clasificaciones" do |t|
      t.string   "simbolo"
      t.string   "limitaciones"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "calicata_id"
    end
  end
end
