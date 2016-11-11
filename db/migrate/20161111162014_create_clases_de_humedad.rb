class CreateClasesDeHumedad < ActiveRecord::Migration
  def change
    create_table :clases_de_humedad do |t|
      t.string :valor, null: false
    end
  end
end
