class AddIndexToPaisaje < ActiveRecord::Migration
  def up
    add_index :paisajes, ["calicata_id"], :name => "index_paisajes_on_calicatas", :unique => true
  end

  def down
    remove_index :paisajes, ["calicata_id"]
  end
end
