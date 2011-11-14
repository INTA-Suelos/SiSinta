class AddMasMockToCalicatas < ActiveRecord::Migration
  def change
    change_table :calicatas do |t|
      t.string :mosaico
      t.string :pedregosidad
      t.string :gran_grupo
      t.string :recorrido
      t.string :aerofoto
      t.string :simbolo
      t.string :limitaciones
      t.string :relieve
      t.string :humedad
      t.string :sales
      t.string :erosion
      t.references :fase
    end
  end
end
