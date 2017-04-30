class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :nombre, null: false
      t.string :pais_alpha_3
      t.references :data_oficial, index: true, polymorphic: true
    end
  end
end
