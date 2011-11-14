class CreatePermeabilidades < ActiveRecord::Migration
  def change
    create_table :permeabilidades do |t|
      t.string :valor
    end
  end
end
