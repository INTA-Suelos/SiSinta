class ArreglarTipoEstructura < ActiveRecord::Migration
  def up
    say 'Arreglando tipos de estructura'
    Estructura.where(tipo_id: 17).update_all('tipo_id = 18')
    Estructura.where(tipo_id: 16).update_all('tipo_id = 17')
    Estructura.where(tipo_id: 15).update_all('tipo_id = 16')
  end

  def down
    say 'Recuperando tipos de estructura'
    Estructura.where(tipo_id: 16).update_all('tipo_id = 15')
    Estructura.where(tipo_id: 17).update_all('tipo_id = 16')
    Estructura.where(tipo_id: 18).update_all('tipo_id = 17')
  end
end
