class AdelgazarPerfiles < ActiveRecord::Migration
  def up
    change_table :perfiles do |t|
      t.remove :nombre
      t.remove :simbolo
      t.references :serie
    end
  end

  def down
    change_table :perfiles do |t|
      t.string :nombre
      t.string :simbolo
      t.remove :serie_id
    end
  end
end
