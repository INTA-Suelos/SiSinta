class CreateTipoDeEstructura < ActiveRecord::Migration
  def change
    create_table :tipos_de_estructura do |t|
      t.string :valor, null: false
    end
  end
end
