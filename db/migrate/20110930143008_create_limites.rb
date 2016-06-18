class CreateLimites < ActiveRecord::Migration
  def change
    create_table :limites do |t|
      t.string :tipo
      t.string :forma
      t.references :horizonte

      t.timestamps null: false
    end
  end
end
