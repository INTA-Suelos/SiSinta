class CreateFormaDeLimite < ActiveRecord::Migration
  def change
    create_table :formas_de_limite do |t|
      t.string :valor, null: false
    end
  end
end
