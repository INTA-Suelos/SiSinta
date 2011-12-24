class AddNombreToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :nombre, :string
  end
end
