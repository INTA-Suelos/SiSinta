class AddMateriaOrganicaCnToAnalisis < ActiveRecord::Migration
  def change
    add_column :analisis, :materia_organica_cn, :integer
  end
end
