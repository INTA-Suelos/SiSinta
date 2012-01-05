class CamposUbicacion < ActiveRecord::Migration
  def up
    change_table :ubicaciones do |t|
      t.string  'recorrido'
      t.string  'mosaico'
      t.integer 'aerofoto'
    end

    change_table :calicatas do |t|
      t.remove 'recorrido'
      t.remove 'mosaico'
      t.remove 'aerofoto'
    end
  end

  def down
    change_table :ubicaciones do |t|
      t.remove 'recorrido'
      t.remove 'mosaico'
      t.remove 'aerofoto'
   end

    change_table :calicatas do |t|
      t.string  'recorrido'
      t.string  'mosaico'
      t.integer 'aerofoto'
    end
  end
end
