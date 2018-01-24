# Autoadministración de datos de usuario (i.e. preferencias). La administración
# para admins está en el panel de administración específico.
class UsuariosController < AutorizadoController
  autocomplete :usuario, :nombre, full: true, extra_data: [:email]
  autocomplete :usuario, :email, full: true, extra_data: [:nombre]

  load_and_authorize_resource

  # Editar preferencias
  def update
    current_usuario.assign_attributes(usuario_params)

    cambio_de_idioma = current_usuario.idioma_changed?

    # Guardamos el usuario pero alteramos el locale para la respuesta si cambió
    # su idioma preferido
    if current_usuario.save && cambio_de_idioma
      I18n.locale = current_usuario.idioma
    end

    respond_with @usuario = current_usuario, location: :root
  end

  private

  def usuario_params
    params.require(:usuario).permit :srid, :ficha_id, :idioma
  end
end
