class AddVegetacionToCalicata < ActiveRecord::Migration
  def change
    add_column :calicatas, :vegetacion_o_cultivos, :string
  end
end
