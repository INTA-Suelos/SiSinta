class AlterFichaDeUsuarios < ActiveRecord::Migration
  def change
    remove_column :usuarios, :ficha
    add_column :usuarios, :ficha, :string, :default => 'completa'
  end
end
