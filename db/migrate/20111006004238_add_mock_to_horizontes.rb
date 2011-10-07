class AddMockToHorizontes < ActiveRecord::Migration
  def change
    add_column :horizontes, :tipo, :string
  end
end
