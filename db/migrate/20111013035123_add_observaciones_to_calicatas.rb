class AddObservacionesToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :observaciones, :string
  end
end
