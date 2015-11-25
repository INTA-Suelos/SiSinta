class CambiarMateriaOrganicaPorCarbonoOrganico < ActiveRecord::Migration
  def change
    rename_column :analiticos, :materia_organica_c, :carbono_organico_c
    rename_column :analiticos, :materia_organica_n, :carbono_organico_n
    rename_column :analiticos, :materia_organica_cn, :carbono_organico_cn
  end
end
