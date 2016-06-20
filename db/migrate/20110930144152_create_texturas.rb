class CreateTexturas < ActiveRecord::Migration
  def change
    create_table :texturas do |t|
      t.decimal :arcilla,           precision: 3, scale: 1
      t.decimal :limo_2_20,         precision: 3, scale: 1
      t.decimal :limo_2_50,         precision: 3, scale: 1
      t.decimal :arena_muy_fina,    precision: 3, scale: 1
      t.decimal :arena_fina,        precision: 3, scale: 1
      t.decimal :arena_media,       precision: 3, scale: 1
      t.decimal :arena_gruesa,      precision: 3, scale: 1
      t.decimal :arena_muy_gruesa,  precision: 3, scale: 1
      t.references :analitico

      t.timestamps null: false
    end
  end
end
