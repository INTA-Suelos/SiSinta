class CambiarEspacioObservaciones < ActiveRecord::Migration
  def up
    notas = Perfil.where(
      'observaciones is not ?', nil
    ).where(
      'observaciones <> ?', '').collect { |p| [p.id, p.observaciones] }

    say 'Aumentando espacio en observaciones'
    say 'Datos:'
    say notas.inspect, true

    change_table :perfiles do |t|
      t.remove :observaciones
      t.text :observaciones, default: nil
    end

    notas.each do |par|
      Perfil.find(par.first).update_attribute(:observaciones, par.last)
    end
  end

  def down
    notas = Perfil.where(
      'observaciones is not ?', nil
    ).where(
      'observaciones <> ?', '').collect { |p| [p.id, p.observaciones] }

    say 'Reduciendo espacio en observaciones'
    say 'Datos:'
    say notas.inspect, true

    change_table :perfiles do |t|
      t.remove :observaciones
      t.string :observaciones, default: nil
    end

    notas.each do |par|
      Perfil.find(par.first).update_attribute(:observaciones, par.last.truncate(255))
    end
  end
end
