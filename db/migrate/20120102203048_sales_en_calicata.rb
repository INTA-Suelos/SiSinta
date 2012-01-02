class SalesEnCalicata < ActiveRecord::Migration
  def up
    change_table :calicatas do |t|
      t.remove :sales
      t.references :sal
    end
  end

  def down
    change_table :calicatas do |t|
      t.remove_references :sal
      t.string :sales
    end
  end
end
