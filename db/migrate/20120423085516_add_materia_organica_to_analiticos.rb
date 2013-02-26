class AddMateriaOrganicaToAnalisis < ActiveRecord::Migration
  def change
    add_column :analisis, :materia_organica_c, :float
    add_column :analisis, :materia_organica_n, :float
  end
end
