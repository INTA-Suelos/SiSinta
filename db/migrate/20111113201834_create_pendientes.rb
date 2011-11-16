class CreatePendientes < ActiveRecord::Migration
  def change
    create_table :pendientes do |t|
      t.string :valor
    end
  end
end
