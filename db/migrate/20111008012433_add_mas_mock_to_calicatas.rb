class AddMasMockToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :mosaico, :string
    add_column :calicatas, :recorrido, :string
    add_column :calicatas, :aerofoto, :string
    add_column :calicatas, :fase_id, :integer
    add_column :calicatas, :simbolo, :string
    add_column :calicatas, :limitaciones, :string
    add_column :calicatas, :gran_grupo, :string
    add_column :calicatas, :relieve, :string
    add_column :calicatas, :humedad, :string
    add_column :calicatas, :sales, :string
    add_column :calicatas, :pedregosidad, :string
    add_column :calicatas, :erosion, :string
  end
end
