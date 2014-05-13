class DropAliasTags < ActiveRecord::Migration
  def up
    drop_table :alias_tags
  end

  def down
    create_table "alias_tags", :id => false, :force => true do |t|
      t.integer "tag_id"
      t.integer "alias_id"
    end

    add_index "alias_tags", ["alias_id"], :name => "index_alias_tags_on_alias_id"
    add_index "alias_tags", ["tag_id"], :name => "index_alias_tags_on_tag_id"
  end
end
