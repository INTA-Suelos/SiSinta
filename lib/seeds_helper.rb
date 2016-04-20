# Métodos varios usados para la carga inicial de datos
# FIXME Logger al STDOUT también
module SeedsHelper
  # Carga el archivo en formato csv +archivo+,  del directorio +semillas+, que
  # tiene datos iniciales para la base de datos.
  def cargar_csv_de(archivo, configuracion = {})
    begin
      Rails.logger.info "Cargando CSV de #{archivo} ..."

      CSV.foreach "db/semillas/#{archivo}.csv", configuracion do |fila|
        yield fila
      end
    rescue => e
      Rails.logger.error "No se pudo procesar #{archivo}: #{e}"
    end
  end
end
