class CreateConsistencias < ActiveRecord::Migration
  def change
    create_table :consistencias do |t|
      t.string :seco
      t.string :humedo
      t.references :horizonte
      t.string :mojado_adhesividad
      t.string :mojado_plasticidad

      t.timestamps
    end
  end
end
