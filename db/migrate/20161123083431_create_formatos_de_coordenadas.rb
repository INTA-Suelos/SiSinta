class CreateFormatosDeCoordenadas < ActiveRecord::Migration
  def change
    create_table :formatos_de_coordenadas do |t|
      t.integer :srid, null: false
      t.string :descripcion, null: false
    end
  end
end
