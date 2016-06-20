class CreateEstructuras < ActiveRecord::Migration
  def change
    create_table :estructuras do |t|
      t.string :tipo
      t.string :clase
      t.string :grado
      t.references :horizonte

      t.timestamps null: false
    end
  end
end
