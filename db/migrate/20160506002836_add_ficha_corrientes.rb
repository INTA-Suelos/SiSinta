class AddFichaCorrientes < ActiveRecord::Migration
  def up
    Ficha.find_or_create_by nombre: 'Formulario Provincia de Corrientes', identificador: 'corrientes'
  end

  def down
    Ficha.where(identificador: 'corrientes').destroy_all
  end
end
