class CreateSubclasesDeHumedad < ActiveRecord::Migration
  def change
    create_table :subclases_de_humedad do |t|
      t.string :valor, null: false
    end
  end
end
