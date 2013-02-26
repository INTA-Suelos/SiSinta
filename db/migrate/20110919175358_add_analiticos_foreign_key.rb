class AddAnalisisForeignKey < ActiveRecord::Migration
  def change
    add_column :analisis, :horizonte_id, :integer
  end
end
