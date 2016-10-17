class CreateConsistenciaEnHumedo < ActiveRecord::Migration
  def change
    create_table :consistencias_en_humedo do |t|
      t.string :valor, null: false
    end
  end
end
