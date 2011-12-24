class EliminarSeries < ActiveRecord::Migration
  def up
    drop_table :series

    remove_column :calicatas, :serie_id
  end

  def down
    create_table "series", :force => true do |t|
      t.string   "provincia"
      t.string   "partido"
      t.string   "simbolo"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "nombre"
    end

    add_column :calicatas, :serie_id, :integer
  end
end
