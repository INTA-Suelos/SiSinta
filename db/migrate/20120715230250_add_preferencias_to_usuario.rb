class AddPreferenciasToUsuario < ActiveRecord::Migration
  def up
    remove_column :usuarios, :ficha
    add_column    :usuarios, :config, :text, default: { ficha: 'completa', srid: '4326' }.to_yaml
  end

  def down
    add_column    :usuarios, :ficha, :string, default: "completa"
    remove_column :usuarios, :config
  end
end
