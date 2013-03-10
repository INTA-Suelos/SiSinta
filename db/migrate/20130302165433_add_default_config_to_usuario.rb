# encoding: utf-8
class AddDefaultConfigToUsuario < ActiveRecord::Migration
  def up
    say "Agregando defaults para la configuración de los usuarios"
    say "{ srid: '4326', ficha: 'completa' }", true
    Usuario.all.map do |u|
      u.srid  ||= '4326'
      u.ficha ||= 'completa'
      u.save(validate: false)
    end
  end

  def down
    say 'Nada que hacer por aquí'
  end
end
