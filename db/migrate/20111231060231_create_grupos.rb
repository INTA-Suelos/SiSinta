class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :codigo
      t.string :descripcion
    end
  end
end
