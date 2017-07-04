class AddImagenToProcesamientos < ActiveRecord::Migration
  def change
    add_attachment :procesamientos, :imagen
  end
end
