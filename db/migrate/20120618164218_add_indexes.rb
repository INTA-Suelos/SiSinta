class AddIndexes < ActiveRecord::Migration
  def up
    add_index :grupos, ["descripcion"], :name => "index_grupos_on_descripcion", :unique => true
    add_index :fases, ["nombre"], :name => "index_fases_on_nombre", :unique => true
  end

  def down
    remove_index :grupos, ["descripcion"]
    remove_index :fases, ["nombre"]
  end
end
