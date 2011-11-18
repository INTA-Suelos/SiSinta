class CorregirAerofotoCalicata < ActiveRecord::Migration
  def up
    remove_column :calicatas, :aerofoto
    add_column    :calicatas, :aerofoto, :integer
  end

  def down
    remove_column :calicatas, :aerofoto
    add_column    :calicatas, :aerofoto, :string
  end
end
