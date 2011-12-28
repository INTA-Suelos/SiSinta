class CambiarLookups < ActiveRecord::Migration
  def up
    change_table :lookups do |t|
      t.rename :simbolo,  :valor1
      t.rename :valor,    :valor2
      t.column            :valor3, :string
    end
  end

  def down
    change_table :lookups do |t|
      t.rename :valor1, :simbolo
      t.rename :valor2, :valor
      t.remove :valor3
    end
  end
end
