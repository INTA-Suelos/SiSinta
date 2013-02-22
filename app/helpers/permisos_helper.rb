# encoding: utf-8
module PermisosHelper
  # Para usar en +grouped_options_for_select+
  def array_equipos_y_usuarios(equipos, usuarios)
    equipos.inject([ [ 'Todos los usuarios', array_usuarios(usuarios) ] ]) do |r, e|
      r << [ "Equipo #{e.nombre}", array_usuarios(e.miembros) ]
      r
    end
  end

  private

    def array_usuarios(usuarios)
      usuarios.inject([]) do |r, u|
        r << [ "#{u.nombre} - #{u.email}" , u.id ]
        r
      end
    end
end
