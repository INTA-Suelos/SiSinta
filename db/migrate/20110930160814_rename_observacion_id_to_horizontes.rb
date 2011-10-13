class RenameObservacionIdToHorizontes < ActiveRecord::Migration
  def up
    rename_column :horizontes, :observacion_id, :calicata_id
  end

  def down
    rename_column :horizontes, :calicata_id, :observacion_id
  end
end
