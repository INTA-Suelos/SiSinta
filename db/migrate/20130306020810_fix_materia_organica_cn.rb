class FixMateriaOrganicaCn < ActiveRecord::Migration
  def up
    change_column :analiticos, :materia_organica_cn, :decimal, precision: 20, scale: 1
  end

  def down
    change_column :analiticos, :materia_organica_cn, :decimal, precision: 2, scale: 1
  end
end
