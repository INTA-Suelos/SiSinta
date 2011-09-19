class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.boolean :ficha_simple
      t.string :password_digest

      t.timestamps
    end
  end
end
