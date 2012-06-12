class AddToHorizontes < ActiveRecord::Migration
  def up
    change_table :horizontes do |t|
      t.references :textura_horizonte
    end
  end

  def down
    change_table :horizontes do |t|
      t.remove_references :textura_horizonte
    end
  end
end
