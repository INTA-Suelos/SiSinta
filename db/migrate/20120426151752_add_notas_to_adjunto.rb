class AddNotasToAdjunto < ActiveRecord::Migration
  def change
    add_column :adjuntos, :notas, :string
  end
end
