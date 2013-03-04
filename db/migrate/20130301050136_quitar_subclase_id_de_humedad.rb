class QuitarSubclaseIdDeHumedad < ActiveRecord::Migration
  def up
    remove_column :humedades, :subclase_id
  end

  def down
    add_column :humedades, :subclase_id, :integer
  end
end
