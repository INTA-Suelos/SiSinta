class CreateClasificaciones < ActiveRecord::Migration
  def change
    create_table :clasificaciones do |t|
      t.string :simbolo
      t.string :limitaciones

      t.timestamps
    end
  end
end
