class CreateUsosDeLaTierra < ActiveRecord::Migration
  def change
    create_table :usos_de_la_tierra do |t|
      t.string :valor, null: false
    end
  end
end
