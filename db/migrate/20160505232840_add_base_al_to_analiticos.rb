class AddBaseAlToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :base_al, :decimal
  end
end
