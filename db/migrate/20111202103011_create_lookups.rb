class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.string :type
      t.string :valor, :nil => false
      t.string :simbolo
    end
  end
end
