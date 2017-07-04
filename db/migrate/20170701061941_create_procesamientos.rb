class CreateProcesamientos < ActiveRecord::Migration
  def change
    create_table :procesamientos do |t|
      t.string :metodologia, null: false
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
