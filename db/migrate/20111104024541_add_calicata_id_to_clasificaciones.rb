class AddCalicataIdToClasificaciones < ActiveRecord::Migration
  def change
    add_column :clasificaciones, :calicata_id, :integer
  end
end
