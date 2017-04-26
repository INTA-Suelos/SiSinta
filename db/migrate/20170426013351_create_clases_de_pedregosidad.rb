class CreateClasesDePedregosidad < ActiveRecord::Migration
  def change
    create_table :clases_de_pedregosidad do |t|
      t.string :valor, null: false
    end
  end
end
