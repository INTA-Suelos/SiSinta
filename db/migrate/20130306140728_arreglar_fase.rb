class ArreglarFase < ActiveRecord::Migration
  def up
    change_column :fases, :nombre, :string
  end

  def down
    change_column :fases, :nombre, :string, limit: 15
  end
end
