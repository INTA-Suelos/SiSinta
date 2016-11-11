class RenameSubclasesEnHumedad < ActiveRecord::Migration
  def change
    rename_column :humedades, :subclase_ids, :subs_ids
  end
end
