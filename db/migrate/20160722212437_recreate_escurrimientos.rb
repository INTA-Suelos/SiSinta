class RecreateEscurrimientos < ActiveRecord::Migration
  def change
    create_table :escurrimientos do |t|
      t.string :valor, null: false
    end
  end
end
