class LookupsParaLimite < ActiveRecord::Migration
  def up
    change_table :limites do |t|
      t.remove :tipo
      t.remove :forma
      t.references :limite_tipo
      t.references :limite_forma
    end
  end

  def down
    change_table :limites do |t|
      t.string :tipo
      t.string :forma
      t.remove_references :limite_tipo
      t.remove_references :limite_forma
    end
  end
end
