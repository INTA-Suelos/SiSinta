class TexturasEnAnaliticos < ActiveRecord::Migration
  def up
    drop_table :texturas

    change_table :analiticos do |t|
      t.decimal :limo_2_20,         :precision => 3, :scale => 1
      t.decimal :limo_2_50,         :precision => 3, :scale => 1
      t.decimal :arena_muy_fina,    :precision => 3, :scale => 1
      t.decimal :arena_fina,        :precision => 3, :scale => 1
      t.decimal :arena_media,       :precision => 3, :scale => 1
      t.decimal :arena_gruesa,      :precision => 3, :scale => 1
      t.decimal :arena_muy_gruesa,  :precision => 3, :scale => 1
    end
  end

  def down
    create_table :texturas do |t|
      t.decimal :arcilla,           :precision => 3, :scale => 1
      t.decimal :limo_2_20,         :precision => 3, :scale => 1
      t.decimal :limo_2_50,         :precision => 3, :scale => 1
      t.decimal :arena_muy_fina,    :precision => 3, :scale => 1
      t.decimal :arena_fina,        :precision => 3, :scale => 1
      t.decimal :arena_media,       :precision => 3, :scale => 1
      t.decimal :arena_gruesa,      :precision => 3, :scale => 1
      t.decimal :arena_muy_gruesa,  :precision => 3, :scale => 1
      t.references :analitico

      t.timestamps
    end

    change_table :analiticos do |t|
      t.remove :limo_2_20
      t.remove :limo_2_50
      t.remove :arena_muy_fina
      t.remove :arena_fina
      t.remove :arena_media
      t.remove :arena_gruesa
      t.remove :arena_muy_gruesa
    end

  end
end
