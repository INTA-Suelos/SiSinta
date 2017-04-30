class CreateTipoDeLimite < ActiveRecord::Migration
  def change
    create_table :tipos_de_limite do |t|
      t.string :valor, null: false
    end
  end
end
