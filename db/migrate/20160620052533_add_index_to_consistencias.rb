class AddIndexToConsistencias < ActiveRecord::Migration
  def change
    add_index :consistencias, :horizonte_id, unique: true
  end
end
