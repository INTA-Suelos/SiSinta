# encoding: utf-8
# Procesa archivos CSV y los convierte en modelos del sistema.
module Deserializador
  # Agrupa cada fila (un horizonte) del archivo, de acuerdo a la columna 'id',
  # que identifica a todos los horizontes de un mismo perfil.
  #
  # archivo  - un String con el path al archivo `csv`.
  # perfiles - un Hash como el que devuelve este método con perfiles ya
  #            acumulados (default: {}).
  #
  # Devuelve un Hash donde la llave es un id de la columna `id` y el valor es
  # un Array de CSV::Row con los horizontes de ese id.
  def self.parsear_csv(archivo, llave, perfiles = {})
    CSV.foreach archivo, headers: true do |f|
      id_temporal = f[llave.to_s]

      perfiles[id_temporal] ||= []
      perfiles[id_temporal] << f
    end
    perfiles
  end

  # Itera sobre los perfiles y sus horizontes (agrupados por +parsear_csv+) y
  # construye un Constructor por cada perfil.
  #
  # perfiles - un Hash como el que devuelve +parsear_csv+ con perfiles ya
  #            acumulados.
  # usuario  - el email del usuario que carga los perfiles (default: nil).
  #
  # Devuelve una colección de Deserializadores instanciados con los datos de
  # cada perfil.
  def self.deserializar_perfiles(perfiles, opciones = {})
    perfiles.map do |_, horizontes|
      Constructor.new(horizontes, opciones)
    end
  end

  # Itera sobre los perfiles y sus horizontes (agrupados por +parsear_csv+) y
  # construye los modelos correspondientes a través de +deserializar_perfiles+.
  #
  # perfiles - un Hash como el que devuelve +parsear_csv+ con perfiles ya
  #            acumulados.
  # usuario  - el email del usuario que carga los perfiles (default: nil).
  #
  # Devuelve una colección de Perfiles instanciados con los datos
  # correspondientes.
  def self.construir_perfiles(perfiles, opciones = {})
    deserializar_perfiles(perfiles, opciones).map do |constructor|
      constructor.construir
    end
  end
end
