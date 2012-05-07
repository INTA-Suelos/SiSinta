class AddProfundidadSuperiorInferiorToHorizonte < ActiveRecord::Migration
  def change
    add_column :horizontes, :profundidad_inferior, :integer
    rename_column :horizontes, :profundidad, :profundidad_superior
  end
end
