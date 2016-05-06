class CreateFichas < ActiveRecord::Migration
  def change
    create_table :fichas do |t|
      t.string :nombre
      t.string :identificador

      t.timestamps
    end
  end
end
