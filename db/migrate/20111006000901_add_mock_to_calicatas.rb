class AddMockToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :referencia, :string
    add_column :calicatas, :ubicacion, :string
    add_column :calicatas, :numero_fotos, :integer
    add_column :calicatas, :unidad_geomorfologica, :string
    add_column :calicatas, :pendiente, :string
    add_column :calicatas, :cobertura, :string
    add_column :calicatas, :material_original, :string
    add_column :calicatas, :taxonomia, :string
    add_column :calicatas, :esquema, :string
  end
end
