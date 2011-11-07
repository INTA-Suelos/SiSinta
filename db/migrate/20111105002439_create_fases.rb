class CreateFases < ActiveRecord::Migration
  def change
    create_table :fases do |t|
      t.string :codigo, :limit => 2
      t.string :nombre, :limit => 15
    end
  end
end
