class FichaNotNil < ActiveRecord::Migration
  def change
    change_column_null :fichas, :nombre, false
    change_column_null :fichas, :identificador, false
  end
end
