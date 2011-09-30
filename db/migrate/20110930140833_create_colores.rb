class CreateColores < ActiveRecord::Migration
  def change
    create_table :colores do |t|
      t.string :seco
      t.string :humedo
      t.integer :horizonte_id

      t.timestamps
    end
  end
end
