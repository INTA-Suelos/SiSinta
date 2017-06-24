class AddIdiomaToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :idioma, :string, default: 'es', null: false
  end
end
