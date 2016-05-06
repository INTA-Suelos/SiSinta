class RenombrarFichaCompleta < ActiveRecord::Migration
  def up
    Ficha.where(identificador: 'completa').update_all identificador: 'clasico'
  end

  def down
    Ficha.where(identificador: 'clasico').update_all identificador: 'completa'
  end
end
