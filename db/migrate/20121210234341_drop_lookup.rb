class DropLookup < ActiveRecord::Migration
  def up
    drop_table :lookups
  end

  def down
    create_table "lookups", :force => true do |t|
      t.string "type"
      t.string "valor2"
      t.string "valor1"
      t.string "valor3"
    end
  end
end
