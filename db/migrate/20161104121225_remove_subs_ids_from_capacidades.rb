class RemoveSubsIdsFromCapacidades < ActiveRecord::Migration
  def change
    remove_column :capacidades, :subs_ids, :text
  end
end
