class CreateLimites < ActiveRecord::Migration
  def change
    create_table :limites do |t|
      t.string :tipo
      t.string :forma
      t.integer :horizonte_id

      t.timestamps
    end
  end
end
