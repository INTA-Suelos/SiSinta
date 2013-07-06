class UpdateRocketTag < ActiveRecord::Migration
  def up
    create_table :alias_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :alias_id
    end

    add_index :alias_tags, :tag_id
    add_index :alias_tags, :alias_id
  end

  def down
    drop_table :alias_tags
  end
end
