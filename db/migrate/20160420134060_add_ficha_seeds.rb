class AddFichaSeeds < ActiveRecord::Migration
  def up
    [
      { nombre: 'Formulario clásico de Etchevere',
      identificador: 'completa' }
    ].each do |ficha|
      Ficha.find_or_create_by nombre: ficha[:nombre], identificador: ficha[:identificador]
    end
  end

  def down
    Ficha.destroy_all
  end
end
