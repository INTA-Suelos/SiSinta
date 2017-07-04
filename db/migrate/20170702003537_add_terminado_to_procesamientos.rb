class AddTerminadoToProcesamientos < ActiveRecord::Migration
  def change
    add_column :procesamientos, :terminado, :boolean, default: false
  end
end
