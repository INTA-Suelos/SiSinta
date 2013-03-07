# encoding: utf-8
module PermisosHelper
  # Para usar en +grouped_options_for_select+
  def usuarios_en_equipos usuarios
    usuarios.inject(HashWithIndifferentAccess.new) do |e, u|
      u.equipos.each do |equipo|
        e[equipo.nombre] ||= []
        e[equipo.nombre] << u.to_opcion
      end
      e['Todos los usuarios'] ||= []
      e['Todos los usuarios'] << u.to_opcion
      e
    end.sort_by { |e| e.last.size }.reverse
  end
end
