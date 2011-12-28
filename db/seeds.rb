# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Carga el archivo en formato yaml (con erb embebido) del directorio
# +semillas+, que tiene datos iniciales para la base de datos
#
def cargar(datos)
  YAML::load(ERB.new(IO.read("#{Rails.root}/db/semillas/#{datos}.yml")).result)
end

#
# Carga los roles predefinidos
#
cargar('roles').each do |campo|
  campo.last.each do |v|
    Rol.send("find_or_create_by_#{campo.first}", v)
  end
end

#
# Carga las tablas de lookup. Deben estar en la forma:
#
# modelo:
#   - [valor1, valor2, valor3]
#   - [valor1, valor2, valor3]
#   ...
#
# donde valor1 debe estar presente y ser único para cada modelo.
cargar('lookup').each do |modelo|
  modelo.last.each do |datos|
    lookup = Kernel.const_get(modelo.first.camelcase).find_or_create_by_valor1(datos[0])
    lookup.update_attributes(:valor2 => datos[1], :valor3 => datos[2])
  end
end

#
# Carga el usuario administrador inicial
#
Usuario.create( :nombre => 'Administrador',
                :email => 'email@falso.com',
                :password => 'administrador').roles << Rol.find_by_nombre('administrador')
