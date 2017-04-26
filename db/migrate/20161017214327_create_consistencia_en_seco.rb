class CreateConsistenciaEnSeco < ActiveRecord::Migration
  def change
    create_table :consistencias_en_seco do |t|
      t.string :valor, null: false
    end
  end
end
