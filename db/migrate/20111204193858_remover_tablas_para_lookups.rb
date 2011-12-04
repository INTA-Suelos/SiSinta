class RemoverTablasParaLookups < ActiveRecord::Migration
  def up
    drop_table :anegamientos
    drop_table :drenajes
    drop_table :escurrimientos
    drop_table :pendientes
    drop_table :permeabilidades
    drop_table :posiciones
    drop_table :relieves
  end

  def down
    create_table "anegamientos", :force => true do |t|
      t.string "valor"
    end

    create_table "drenajes", :force => true do |t|
      t.string "valor"
    end

    create_table "escurrimientos", :force => true do |t|
      t.string "valor"
    end

    create_table "pendientes", :force => true do |t|
      t.string "valor"
    end

    create_table "permeabilidades", :force => true do |t|
      t.string "valor"
    end

    create_table "posiciones", :force => true do |t|
      t.string "valor"
    end

    create_table "relieves", :force => true do |t|
      t.string "valor"
    end
  end
end
