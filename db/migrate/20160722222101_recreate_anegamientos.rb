class RecreateAnegamientos < ActiveRecord::Migration
  def change
    create_table :anegamientos do |t|
      t.string :valor, null: false
    end
  end
end
