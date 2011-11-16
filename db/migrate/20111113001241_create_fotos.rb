class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.references :calicata
      t.timestamps
    end
  end
end
