class CreateRelieves < ActiveRecord::Migration
  def change
    create_table :relieves do |t|
      t.string :valor
    end
  end
end
