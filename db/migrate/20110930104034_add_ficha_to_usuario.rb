class AddFichaToUsuario < ActiveRecord::Migration
  def change
    remove_column :usuarios, :ficha_simple
    add_column :usuarios, :ficha, :string, :default => 'ficha_completa'
  end
end
