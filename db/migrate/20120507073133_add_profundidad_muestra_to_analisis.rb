class AddProfundidadMuestraToAnalisis < ActiveRecord::Migration
  def change
    add_column :analisis, :profundidad_muestra, :string
  end
end
