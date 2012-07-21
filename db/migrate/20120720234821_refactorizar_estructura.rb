class RefactorizarEstructura < ActiveRecord::Migration
  def up
    change_table :estructuras do |t|
      t.integer :tipo_de_estructura_id
      t.integer :clase_de_estructura_id
      t.integer :grado_de_estructura_id
      t.remove :tipo
      t.remove :grado
      t.remove :clase
    end
  end

  def down
    change_table :estructuras do |t|
      t.string   "tipo"
      t.string   "clase"
      t.string   "grado"
      t.remove :tipo_de_estructura_id
      t.remove :clase_de_estructura_id
      t.remove :grado_de_estructura_id
    end
  end
end
