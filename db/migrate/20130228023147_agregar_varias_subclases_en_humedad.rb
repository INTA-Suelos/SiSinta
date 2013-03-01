class AgregarVariasSubclasesEnHumedad < ActiveRecord::Migration
  def change
    add_column :humedades, :subclase_ids, :text
  end
end
