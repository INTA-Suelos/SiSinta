# encoding: utf-8
class MateriaOrganicaCnDecimal < ActiveRecord::Migration
  def up
    say 'Convirtiendo C/N en decimal con precisión 0.0'
    datos = Analitico.where('materia_organica_cn is not ?', nil).collect do |a|
      par = [a.id, a.materia_organica_cn]
      say par.inspect, true
      par
    end

    change_table :analiticos do |t|
      t.remove :materia_organica_cn
      t.decimal :materia_organica_cn, precision: 2, scale: 1
    end

    datos.each do |par|
      Analitico.find(par.first).update_attribute(
        :materia_organica_cn, par.last)
    end
  end

  def down
    say 'Convirtiendo C/N en integer'
    datos = Analitico.where('materia_organica_cn is not ?', nil).collect do |a|
      par = [a.id, a.materia_organica_cn]
      say par.inspect, true
      par
    end

    change_table :analiticos do |t|
      t.remove :materia_organica_cn
      t.integer :materia_organica_cn
    end

    datos.each do |par|
      Analitico.find(par.first).update_attribute(
        :materia_organica_cn, par.last.round)
    end
  end
end
