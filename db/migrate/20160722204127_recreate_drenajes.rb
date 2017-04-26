class RecreateDrenajes < ActiveRecord::Migration
  def change
    create_table :drenajes do |t|
      t.string :valor, null: false
    end
  end
end
