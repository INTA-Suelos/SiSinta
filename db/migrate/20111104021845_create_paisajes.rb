class CreatePaisajes < ActiveRecord::Migration
  def change
    create_table :paisajes do |t|
      t.string :tipo
      t.string :forma
      t.string :simbolo

      t.timestamps
    end
  end
end
