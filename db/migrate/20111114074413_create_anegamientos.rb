class CreateAnegamientos < ActiveRecord::Migration
  def change
    create_table :anegamientos do |t|
      t.string :valor
    end
  end
end
