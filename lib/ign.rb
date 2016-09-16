# Datos de http://ign.gob.ar/archivos/sig250/PROVINCIAS.zip
# Convertidos a geografías (-G, asume SRID: 4326) e indizados (-I) con
#
#    shp2pgsql -G -I PROVINCIAS ign_provincias > ign_provincias.sql
#
# y cargados en la tabla `ign_provincias`. El modelo de Provincia se relaciona
# con esta tabla a través del gid
#
# Requiere el comando shp2pgsql
require 'net/http'
require 'fileutils'
require 'zip'
require 'open3'

class Ign
  URL_BASE = 'http://ign.gob.ar/archivos/sig250'

  # Tipo debería ser "provincias" o "departamentos"
  def initialize(tipo)
    @tipo = tipo
    @zip = File.join Dir.tmpdir, "#{tipo}.zip"
    @sql = File.join Dir.tmpdir, "#{tipo}.sql"
  end

  # Corre el proceso completo sin descargar el zip, si ya existe
  def hacer_todo
    descargar unless File.exists?(@zip)
    extraer
    convertir
    importar
  end

  # Importa shapefiles con información geográfica de provincias a la DB
  def importar
    ActiveRecord::Base.logger.silence do
      ActiveRecord::Base.connection.execute("drop table if exists #{table}")
      ActiveRecord::Base.connection.execute(IO.read(@sql))
    end
  end

  # Convierte las shapefiles en comandos sql para postgis. Opciones usadas:
  #
  #   -G  Use geography type (requires lon/lat data or -s to reproject).
  #   -I  Create a spatial index on the geocolumn.
  def convertir
    # El comando necesita estar en el directorio donde se extrajeron los
    # archivos
    Dir.chdir Dir.tmpdir do
      File.open(@sql, 'w') do |sql|
        salida, _ = Open3.capture2('shp2pgsql', '-G', '-I', shapefile, table)

        sql.write salida
      end
    end
  end

  # Extrae el zip descargado del IGN en /tmp
  def extraer
    # No frenar si existen los archivos a extraer
    Zip.on_exists_proc = true

    Zip::File.open(@zip) do |archivo_zip|
      archivo_zip.each do |archivo|
        # Extrae los archivos sueltos en /tmp
        next if archivo.directory?
        archivo.extract File.join(Dir.tmpdir, File.basename(archivo.name))
      end
    end
  end

  # Descarga y renombra el zip desde los servidores del IGN según el tipo
  # indicado al instanciar
  def descargar
    zip_temporal = Net::HTTP.get URI(@url)

    File.open(@zip, 'wb') do |archivo_zip|
      archivo_zip.write(zip_temporal)
    end
  end

  # El nombre del grupo de archivos de formas. Depende de cómo el IGN provee
  # los datos
  def shapefile
    @tipo.upcase
  end

  # La url desde donde descargar los datos
  def url
    "#{URL_BASE}/#{@tipo.upcase}.zip"
  end

  # La tabla de la base de datos donde importar el shapefile
  def table
    "ign_#{@tipo}"
  end
end
