class AddAnaliticosForeignKey < ActiveRecord::Migration
  def change
    add_column :analiticos, :horizonte_id, :integer
  end
end
