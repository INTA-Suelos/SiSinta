class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :provincia
      t.string :partido
      t.string :simbolo

      t.timestamps
    end
  end
end
