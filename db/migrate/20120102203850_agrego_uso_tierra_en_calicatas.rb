class AgregoUsoTierraEnCalicatas < ActiveRecord::Migration
  def up
    change_table :calicatas do |t|
      t.remove :uso_tierra
      t.references :uso_tierra
    end
  end

  def down
    change_table :calicatas do |t|
      t.remove_references :uso_tierra
      t.string :uso_tierra
    end
  end
end
