class CreateAnaliticos < ActiveRecord::Migration
  def change
    create_table :analiticos do |t|
      t.integer :registro
      t.decimal :humedad
      t.decimal :s
      t.decimal :t
      t.decimal :ph_pasta
      t.decimal :ph_h2o
      t.decimal :ph_kcl
      t.decimal :resistencia_pasta
      t.decimal :base_ca
      t.decimal :base_mg
      t.decimal :base_k
      t.decimal :base_na

      t.timestamps null: false
    end
  end
end
