class RemoveFieldsFromHorizontes < ActiveRecord::Migration
  def up
    remove_column :horizontes, :color_seco
    remove_column :horizontes, :color_humedo
    remove_column :horizontes, :tipo
    remove_column :horizontes, :clase
    remove_column :horizontes, :grado
  end

  def down
    change_table :horizontes do |t|
      t.string :color_seco
      t.string :color_humedo
      t.string :tipo
      t.string :clase
      t.string :grado
    end
  end
end
