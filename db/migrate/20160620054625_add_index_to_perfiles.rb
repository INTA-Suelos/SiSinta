class AddIndexToPerfiles < ActiveRecord::Migration
  def change
    add_index :perfiles, :serie_id
    add_index :perfiles, :usuario_id
  end
end
