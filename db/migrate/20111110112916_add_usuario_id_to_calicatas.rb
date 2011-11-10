class AddUsuarioIdToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :usuario_id, :integer
  end
end
