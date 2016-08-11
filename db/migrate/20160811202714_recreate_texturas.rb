class RecreateTexturas < ActiveRecord::Migration
  def change
    create_table :texturas do |t|
      t.string :clase, null: false
      t.string :textura
      t.string :suelo
    end
  end
end
