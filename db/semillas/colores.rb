# Carga la tabla de conversión de color Munsell
unless Color.any?
  cargar_csv_de('munsell', headers: true, col_sep: ',') do |color|
    Color.find_or_create_by(hvc: "#{color[1]} #{color[2]}/#{color[3]}") do |nuevo|
      r = [(color[4].to_f * 255).round, 255].min
      g = [(color[5].to_f * 255).round, 255].min
      b = [(color[6].to_f * 255).round, 255].min
      nuevo.rgb = "rgb(#{r}, #{g}, #{b})"
    end
  end
end
