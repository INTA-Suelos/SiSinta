class ExtraigoGrupoDeCalicata < ActiveRecord::Migration
  def up
    change_table :calicatas do |t|
      t.remove :gran_grupo
      t.integer :grupo_id
    end
  end

  def down
    change_table :calicatas do |t|
      t.remove :grupo_id
      t.string :gran_grupo
    end
  end
end
