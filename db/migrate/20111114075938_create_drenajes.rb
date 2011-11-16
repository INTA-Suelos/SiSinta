class CreateDrenajes < ActiveRecord::Migration
  def change
    create_table :drenajes do |t|
      t.string :valor
    end
  end
end
