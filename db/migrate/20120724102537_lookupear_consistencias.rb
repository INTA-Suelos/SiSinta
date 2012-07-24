class LookupearConsistencias < ActiveRecord::Migration
  def up
    change_table :consistencias do |t|
      t.remove :seco, :humedo, :mojado_adhesividad, :mojado_plasticidad
      t.integer :en_seco_id
      t.integer :en_humedo_id
      t.integer :adhesividad_id
      t.integer :plasticidad_id
    end
  end

  def down
    change_table :consistencias do |t|
      t.remove :en_seco_id, :en_humedo_id, :adhesividad_id, :plasticidad_id
      t.string :seco
      t.string :humedo
      t.string :mojado_adhesividad
      t.string :mojado_plasticidad
    end
  end
end
