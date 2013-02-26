class AddMateriaOrganicaToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :materia_organica_c, :float
    add_column :analiticos, :materia_organica_n, :float
  end
end
