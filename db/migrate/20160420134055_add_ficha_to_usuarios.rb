class AddFichaToUsuarios < ActiveRecord::Migration
  def change
    add_reference :usuarios, :ficha, index: true, default: 1
  end
end
