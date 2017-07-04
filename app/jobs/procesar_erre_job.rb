class ProcesarErreJob < ActiveJob::Base
  queue_as :default

  def perform(seleccion, perfil_ids)
    perfil_ids.each do |perfil|
      seleccion.perfiles << Perfil.find(perfil)
    end

    if seleccion.perfiles.any?

      csv = Tempfile.new(["csv_#{seleccion.id}", '.csv'], '/tmp').tap do |file|
        file.write CSVSerializer.new(seleccion.perfiles).as_csv(headers: true)
        file.close
      end

      png = Tempfile.new(["seleccion_#{seleccion.id}", '.png'], '/tmp')

      binding.pry
      if system Rails.root.join('bin', 'slabs.R').to_s, csv.path, png.path
        seleccion.imagen = png
      binding.pry
        seleccion.save
      end
    end
  end
end
