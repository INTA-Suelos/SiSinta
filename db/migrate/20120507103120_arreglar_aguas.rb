class ArreglarAguas < ActiveRecord::Migration
  def up
    change_table :analiticos do |t|
      t.decimal :agua_3_atm, :precision => 3, :scale => 2
      t.rename :agua_ret, :agua_15_atm
    end
  end

  def down
    change_table :analiticos do |t|
      t.remove :agua_3_atm
      t.rename :agua_15_atm, :agua_ret
    end
  end
end
