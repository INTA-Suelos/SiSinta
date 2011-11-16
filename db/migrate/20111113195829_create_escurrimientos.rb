class CreateEscurrimientos < ActiveRecord::Migration
  def change
    create_table :escurrimientos do |t|
      t.string :valor
    end
  end
end
