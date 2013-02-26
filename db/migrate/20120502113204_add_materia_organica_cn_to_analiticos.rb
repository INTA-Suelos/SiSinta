class AddMateriaOrganicaCnToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :materia_organica_cn, :integer
  end
end
