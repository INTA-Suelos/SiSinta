class RemoveSubsIdsFromHumedades < ActiveRecord::Migration
  def change
    remove_column :humedades, :subs_ids, :text
  end
end
