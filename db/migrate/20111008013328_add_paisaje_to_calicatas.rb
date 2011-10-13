class AddPaisajeToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :paisaje, :string
  end
end
