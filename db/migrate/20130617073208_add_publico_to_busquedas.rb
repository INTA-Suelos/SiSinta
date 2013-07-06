class AddPublicoToBusquedas < ActiveRecord::Migration
  def change
    add_column :busquedas, :publico, :boolean, default: false
  end
end
