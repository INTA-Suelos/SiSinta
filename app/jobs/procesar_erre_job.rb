class ProcesarErreJob < ActiveJob::Base
  queue_as :default

  def perform(procesamiento)
    opciones = { encoding: Encoding::UTF_8 }

    csv = Tempfile.new(["csv_#{procesamiento.id}", '.csv'], '/tmp', opciones).tap do |file|
      file.write CSVSerializer.new(procesamiento.perfiles.dup).as_csv(headers: true, base: Perfil)
      file.close
    end

    png = Tempfile.new(["procesamiento_#{procesamiento.id}", '.png'], '/tmp')

    if system Rails.root.join('bin', procesamiento.metodologia).to_s, csv.path, png.path
      procesamiento.imagen = png
    end

    procesamiento.save
  end
end
