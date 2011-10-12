class AddSarasaToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :sarasa, :string
  end
end
