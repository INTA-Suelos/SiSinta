class RenameSubclasesEnCapacidad < ActiveRecord::Migration
  def change
    rename_column :capacidades, :subclase_ids, :subs_ids
  end
end
