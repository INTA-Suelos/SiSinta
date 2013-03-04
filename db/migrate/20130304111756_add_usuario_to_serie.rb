class AddUsuarioToSerie < ActiveRecord::Migration
  def change
    add_column :series, :usuario_id, :integer
  end
end
