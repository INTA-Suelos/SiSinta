class CreateHorizontes < ActiveRecord::Migration
  def change
    create_table :horizontes do |t|
      t.integer :profundidad
      t.string :color_seco
      t.string :color_humedo
      t.string :tipo
      t.string :clase
      t.string :grado
      t.float :ph
      t.string :textura

      t.timestamps
    end
  end
end
