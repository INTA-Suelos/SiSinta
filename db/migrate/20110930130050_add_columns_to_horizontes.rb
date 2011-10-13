class AddColumnsToHorizontes < ActiveRecord::Migration
  def change
    add_column :horizontes, :humedad, :string
    add_column :horizontes, :raices, :string
    add_column :horizontes, :formaciones_especiales, :string
    add_column :horizontes, :moteados, :string
    add_column :horizontes, :barnices, :string
    add_column :horizontes, :concreciones, :string
    add_column :horizontes, :co3, :string
  end
end
