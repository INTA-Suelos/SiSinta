class CreateClaseDeEstructura < ActiveRecord::Migration
  def change
    create_table :clases_de_estructura do |t|
      t.string :valor, null: false
    end
  end
end
