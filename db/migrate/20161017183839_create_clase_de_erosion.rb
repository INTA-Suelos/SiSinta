class CreateClaseDeErosion < ActiveRecord::Migration
  def change
    create_table :clases_de_erosion do |t|
      t.string :valor, null: false
    end
  end
end
