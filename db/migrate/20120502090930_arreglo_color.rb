class ArregloColor < ActiveRecord::Migration
  def up
    change_table :colores do |t|
      t.string :hvc, null: false
      t.string :rgb, null: false
      t.remove :seco, :humedo
      t.remove_timestamps
      t.remove_references :horizonte

      t.index :hvc, unique: true
      t.index :rgb, unique: true
    end

    change_table :horizontes do |t|
      t.integer :color_seco_id, :color_humedo_id
    end

  end

  def down
    change_table :colores do |t|
      t.remove :hvc, :rgb
      t.string :seco, :humedo
      t.timestamps
      t.references :horizonte
    end

    change_table :horizontes do |t|
      t.remove :color_seco_id, :color_humedo_id
    end
  end
end
