class AddCalicataIdToPaisajes < ActiveRecord::Migration
  def change
    add_column :paisajes, :calicata_id, :integer
  end
end
