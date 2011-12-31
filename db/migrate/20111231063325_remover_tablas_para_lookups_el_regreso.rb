class RemoverTablasParaLookupsElRegreso < ActiveRecord::Migration
  def up
    drop_table :capacidad_clases
    drop_table :capacidad_subclases
  end

  def down
    create_table "capacidad_clases", :force => true do |t|
      t.string "codigo"
      t.string "descripcion"
      t.string "agrupamiento"
    end

    create_table "capacidad_subclases", :force => true do |t|
      t.string "codigo"
      t.string "descripcion"
    end
  end
end
