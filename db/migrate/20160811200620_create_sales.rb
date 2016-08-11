class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :valor, null: false
    end
  end
end
