class RecreateRelieves < ActiveRecord::Migration
  def change
    create_table :relieves do |t|
      t.string :valor, null: false
    end
  end
end
