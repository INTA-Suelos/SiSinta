# encoding: utf-8
module UsuariosHelper
  def link_to_eliminar(usuario)
    admins = Usuario.admins.all
    if(admins.include?(usuario) and admins.size == 1)
      link_to('Eliminar', nil, { class: 'eliminar_admin' } )
    else
      link_to('Eliminar', usuario, data: {confirm: '¿Estás seguro?'}, method: :delete)
    end
  end

end
