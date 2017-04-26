class RecreatePosiciones < ActiveRecord::Migration
  def change
    create_table :posiciones do |t|
      t.string :valor, null: false
    end
  end
end
