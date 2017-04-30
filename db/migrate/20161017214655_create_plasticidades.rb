class CreatePlasticidades < ActiveRecord::Migration
  def change
    create_table :plasticidades do |t|
      t.string :valor, null: false
    end
  end
end
