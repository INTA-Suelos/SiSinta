class RecreatePendientes < ActiveRecord::Migration
  def change
    create_table :pendientes do |t|
      t.string :valor, null: false
    end
  end
end
