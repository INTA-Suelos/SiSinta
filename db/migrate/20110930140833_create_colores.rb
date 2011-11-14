class CreateColores < ActiveRecord::Migration
  def change
    create_table :colores do |t|
      t.string :seco
      t.string :humedo
      t.references :horizonte

      t.timestamps
    end
  end
end
