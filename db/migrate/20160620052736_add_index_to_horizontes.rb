class AddIndexToHorizontes < ActiveRecord::Migration
  def change
    add_index :horizontes, :perfil_id
  end
end
