class Anegamiento < ApplicationRecord
  translates :valor
end

class AddTranslationTableToAnegamiento < ActiveRecord::Migration
  def up
    Anegamiento.create_translation_table!({
      valor: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    Anegamiento.drop_translation_table! migrate_data: true
  end
end
