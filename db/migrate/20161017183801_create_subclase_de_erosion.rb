class CreateSubclaseDeErosion < ActiveRecord::Migration
  def change
    create_table :subclases_de_erosion do |t|
      t.string :valor, null: false
    end
  end
end
