class CreateEstructuras < ActiveRecord::Migration
  def change
    create_table :estructuras do |t|
      t.string :tipo
      t.string :clase
      t.string :grado
      t.integer :horizonte_id

      t.timestamps
    end
  end
end
