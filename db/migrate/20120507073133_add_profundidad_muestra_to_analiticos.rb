class AddProfundidadMuestraToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :profundidad_muestra, :string
  end
end
