class RemoveUbicacionFromCalicatas < ActiveRecord::Migration
  def up
    remove_column :calicatas, :ubicacion
  end

  def down
    add_column :calicatas, :ubicacion, :string
  end
end
