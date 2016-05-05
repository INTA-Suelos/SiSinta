class RenombrarFichaCompleta < ActiveRecord::Migration
  def up
    Ficha.where(identificador: 'completa').update_all identificador: 'clasico'
  end
end
