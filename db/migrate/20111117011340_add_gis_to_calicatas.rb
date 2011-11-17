class AddGisToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :ubicacion_id, :integer
  end
end
