# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Carga el archivo en formato yaml (con erb embebido) del directorio
# +semillas+, que tiene datos iniciales para la base de datos
def cargar(datos)
  YAML::load(ERB.new(IO.read("#{Rails.root}/db/semillas/#{datos}.yml")).result)
end

admin = Rol.find_or_create_by_nombre('admin')
usuario = Usuario.create( :nombre => 'Administrador', :email =>
'email@falso.com', :password => 'administrador')
usuario.roles << admin
