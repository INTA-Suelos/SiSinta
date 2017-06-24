class ClaseDeCapacidad < ActiveRecord::Base
  translates :codigo, :descripcion, :categoria, foreign_key: :clase_de_capacidad_id
end

class AddTranslationTableToClaseDeCapacidad < ActiveRecord::Migration
  def up
    ClaseDeCapacidad.create_translation_table!({
      codigo: :string,
      descripcion: :string,
      categoria: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    ClaseDeCapacidad.drop_translation_table! migrate_data: true
  end
end
