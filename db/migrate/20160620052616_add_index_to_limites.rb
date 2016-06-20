class AddIndexToLimites < ActiveRecord::Migration
  def change
    add_index :limites, :horizonte_id, unique: true
  end
end
