class AddUsuarioToAdjuntos < ActiveRecord::Migration
  def change
    add_reference :adjuntos, :usuario, index: true
  end
end
