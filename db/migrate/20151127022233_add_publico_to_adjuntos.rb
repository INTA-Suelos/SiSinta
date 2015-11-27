class AddPublicoToAdjuntos < ActiveRecord::Migration
  def change
    add_column :adjuntos, :publico, :boolean, default: false
  end
end
