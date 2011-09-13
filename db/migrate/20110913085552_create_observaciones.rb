class CreateObservaciones < ActiveRecord::Migration
  def change
    create_table :observaciones do |t|
      t.date :fecha
      t.string :numero
      t.boolean :modal

      t.timestamps
    end
  end
end
