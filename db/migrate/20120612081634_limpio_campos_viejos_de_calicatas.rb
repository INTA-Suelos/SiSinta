class LimpioCamposViejosDeCalicatas < ActiveRecord::Migration
  def up
    change_table :calicatas do |t|
      t.remove :humedad_uniforme
      t.remove :pedregosidad
      t.remove :vegetacion
      t.remove :cobertura
      t.remove :taxonomia

      t.references :pedregosidad
    end
  end

  def down
    change_table :calicatas do |t|
      t.boolean :humedad_uniforme
      t.string :pedregosidad
      t.string :vegetacion
      t.string :cobertura
      t.string :taxonomia

      t.remove_references :pedregosidad
    end
  end
end
