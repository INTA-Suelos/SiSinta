class AddIndexToAnaliticos < ActiveRecord::Migration
  def change
    add_index :analiticos, :horizonte_id, unique: true
  end
end
