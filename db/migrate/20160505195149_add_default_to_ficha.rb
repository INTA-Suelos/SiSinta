class AddDefaultToFicha < ActiveRecord::Migration
  def change
    add_column :fichas, :default, :boolean, default: false
  end
end
