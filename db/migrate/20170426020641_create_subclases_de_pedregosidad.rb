class CreateSubclasesDePedregosidad < ActiveRecord::Migration
  def change
    create_table :subclases_de_pedregosidad do |t|
      t.string :valor, null: false
    end
  end
end
