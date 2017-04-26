class CreateAdhesividades < ActiveRecord::Migration
  def change
    create_table :adhesividades do |t|
      t.string :valor, null: false
    end
  end
end
