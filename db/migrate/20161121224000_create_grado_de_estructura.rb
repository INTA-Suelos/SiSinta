class CreateGradoDeEstructura < ActiveRecord::Migration
  def change
    create_table :grados_de_estructura do |t|
      t.string :valor, null: false
    end
  end
end
