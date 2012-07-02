# -*- encoding : utf-8 -*-
require 'csv'
# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.

# Carga el archivo de semillas +archivo+, en formato yaml (con erb embebido) del
# directorio +semillas+, que tiene datos iniciales para la base de datos
def cargar_yml_de(archivo)
  YAML::load(ERB.new(IO.read("#{Rails.root}/db/semillas/#{archivo}.yml")).result)
end

# Carga el archivo en formato csv +archivo+,  del directorio +semillas+, que
# tiene datos iniciales para la base de datos.
def cargar_csv_de(archivo, configuracion = {})
  begin
    puts "Cargando CSV de #{archivo} ..."
    CSV.foreach "#{Rails.root}/db/semillas/#{archivo}.csv", configuracion do |fila|
      yield fila
    end
  rescue
    puts "No se pudo abrir #{archivo}"
  end
end

# Carga los roles predefinidos
cargar_yml_de('roles').each do |campo|
  campo.last.each do |v|
    puts "Cargando rol #{v} ..."
    Rol.send("find_or_create_by_#{campo.first}", v)
  end
end

# Carga el usuario administrador inicial
Usuario.create( :nombre => 'Administrador',
                :email => 'email@falso.com',
                :password => 'administrador').roles.clear << Rol.find_by_nombre('administrador')

# Carga la tabla de conversión de color Munsell
cargar_csv_de('munsell', headers: true, col_sep: ';') do |color|
  Color.find_or_create_by_hvc("#{color[0]} #{color[1]}/#{color[2]}") do |nuevo|
    r = [(color[6].to_f * 255).round, 255].min
    g = [(color[7].to_f * 255).round, 255].min
    b = [(color[8].to_f * 255).round, 255].min
    nuevo.rgb = "rgb(#{r}, #{g}, #{b})"
  end
end

# Cargamos perfiles modales ya digitalizados
cargar_csv_de('perfiles-modales', headers:true, col_sep: ',') do |csv|
  Calicata.find_or_create_by_nombre(nombre: csv[0]) do |p|
    p.modal = true
    p.fecha = csv[1]
    p.create_ubicacion( x: csv[2], y: csv[3],
                        mosaico: csv[4].try(:split, ',').try(:first),
                        descripcion: csv[5])
    p.numero = csv[6]
    p.grupo = Grupo.find_or_create_by_descripcion(csv[7])
  end
end
