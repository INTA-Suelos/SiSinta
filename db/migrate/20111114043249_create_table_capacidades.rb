class CreateTableCapacidades < ActiveRecord::Migration
  def change
    create_table :capacidades do |t|
      t.references :calicata
      t.references :capacidad_clase
    end
  end
end
