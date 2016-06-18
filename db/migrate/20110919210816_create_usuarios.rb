class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.boolean :ficha_simple

      t.timestamps null: false
    end
  end
end
