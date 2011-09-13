class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.date :fecha
      t.string :numero
      t.boolean :modal

      t.timestamps
    end
  end
end
