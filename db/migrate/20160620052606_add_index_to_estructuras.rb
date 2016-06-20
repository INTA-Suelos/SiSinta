class AddIndexToEstructuras < ActiveRecord::Migration
  def change
    add_index :estructuras, :horizonte_id, unique: true
  end
end
