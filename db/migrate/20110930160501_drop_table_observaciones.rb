class DropTableObservaciones < ActiveRecord::Migration
  def up
    drop_table :observaciones
  end

  def down
    create_table :observaciones do |t|
      t.date :fecha
      t.string :numero
      t.boolean :modal

      t.timestamps
    end
  end
end
