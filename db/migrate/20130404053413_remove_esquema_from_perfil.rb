class RemoveEsquemaFromPerfil < ActiveRecord::Migration
  def up
    remove_column :perfiles, :esquema
  end

  def down
    add_column :perfiles, :esquema, :string
  end
end
