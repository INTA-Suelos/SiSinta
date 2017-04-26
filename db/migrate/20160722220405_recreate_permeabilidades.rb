class RecreatePermeabilidades < ActiveRecord::Migration
  def change
    create_table :permeabilidades do |t|
      t.string :valor, null: false
    end
  end
end
