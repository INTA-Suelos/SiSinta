class RemoveTexturaFromHorizontes < ActiveRecord::Migration
  def up
    remove_column :horizontes, :textura
  end

  def down
    add_column :horizontes, :textura, :string
  end
end
