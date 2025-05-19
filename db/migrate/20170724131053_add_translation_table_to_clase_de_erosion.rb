class ClaseDeErosion < ApplicationRecord
  translates :valor, foreign_key: :clase_de_erosion_id
end

class AddTranslationTableToClaseDeErosion < ActiveRecord::Migration
  def up
    ClaseDeErosion.create_translation_table!({
      valor: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    ClaseDeErosion.drop_translation_table! migrate_data: true
  end
end
