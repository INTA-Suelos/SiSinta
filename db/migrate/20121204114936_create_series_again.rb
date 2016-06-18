class CreateSeriesAgain < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :nombre
      t.string :simbolo
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
