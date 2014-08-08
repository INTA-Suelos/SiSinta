# encoding: utf-8
require 'csv'
# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.

# Carga el archivo de semillas +archivo+, en formato yaml (con erb embebido) del
# directorio +semillas+, que tiene datos iniciales para la base de datos
def cargar_yml_de(archivo)
  YAML::load(ERB.new(IO.read("db/semillas/#{archivo}.yml")).result)
end

# Carga el archivo en formato csv +archivo+,  del directorio +semillas+, que
# tiene datos iniciales para la base de datos.
def cargar_csv_de(archivo, configuracion = {})
  begin
    puts "Cargando CSV de #{archivo} ..."
    CSV.foreach "db/semillas/#{archivo}.csv", configuracion do |fila|
      yield fila
    end
  rescue => e
    puts "No se pudo procesar #{archivo}: #{e}"
  end
end

# Carga el usuario administrador inicial
puts <<MSG

Creando usuario administrador con:
  email:    admin@cambiame.com
  password: cambiame

MSG

Usuario.create(
  nombre:   'Administra Administrador',
  email:    'admin@cambiame.com',
  password: 'cambiame'
).grant 'Administrador'

# Carga la tabla de conversión de color Munsell
cargar_csv_de('munsell', headers: true, col_sep: ',') do |color|
  Color.find_or_create_by(hvc: "#{color[1]} #{color[2]}/#{color[3]}") do |nuevo|
    r = [(color[4].to_f * 255).round, 255].min
    g = [(color[5].to_f * 255).round, 255].min
    b = [(color[6].to_f * 255).round, 255].min
    nuevo.rgb = "rgb(#{r}, #{g}, #{b})"
  end
end

if File.exists?('db/semillas/perfiles-modales.csv')
  # Cargamos perfiles modales ya digitalizados
  cargar_csv_de('perfiles-modales', headers:true, col_sep: ',') do |csv|
    Serie.find_or_create_by(nombre: csv[0]) do |s|
      mosaico, observaciones = csv[4].try(:split, ',')
      grupo = Grupo.find_or_create_by(descripcion: csv[7])
      s.perfiles.build(
        fecha: csv[1],
        ubicacion_attributes: { x: csv[2], y: csv[3],
                                mosaico: mosaico,
                                descripcion: csv[5] },
        modal: true,
        numero: csv[6],
        grupo: grupo,
        observaciones: observaciones
      )
    end
  end
end
