class Adhesividad < ApplicationRecord
  translates :valor
end

class AddTranslationTableToAdhesividad < ActiveRecord::Migration
  def up
    Adhesividad.create_translation_table!({
      valor: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    Adhesividad.drop_translation_table! migrate_data: true
  end
end
