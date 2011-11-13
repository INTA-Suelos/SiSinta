class AddNombreToSeries < ActiveRecord::Migration
  def change
    add_column :series, :nombre, :string
  end
end
