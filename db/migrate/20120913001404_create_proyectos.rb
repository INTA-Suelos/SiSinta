class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.text :descripcion
      t.text :cita

      t.timestamps
    end

    add_index :proyectos, [:nombre], unique: true

    create_table "perfiles_proyectos", id: false do |t|
      t.references :proyecto
      t.references :perfil
    end
  end
end
