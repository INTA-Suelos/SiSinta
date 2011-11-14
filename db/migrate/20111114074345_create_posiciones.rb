class CreatePosiciones < ActiveRecord::Migration
  def change
    create_table :posiciones do |t|
      t.string :valor
    end
  end
end
