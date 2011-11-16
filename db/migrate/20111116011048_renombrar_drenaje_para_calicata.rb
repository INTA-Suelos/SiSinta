class RenombrarDrenajeParaCalicata < ActiveRecord::Migration
  def up
    rename_column :calicatas, :drenaje, :drenaje_id
  end

  def down
    rename_column :calicatas, :drenaje_id, :drenaje
  end
end
