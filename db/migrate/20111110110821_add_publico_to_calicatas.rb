class AddPublicoToCalicatas < ActiveRecord::Migration
  def change
    add_column :calicatas, :publico, :boolean, :default => false
  end
end
