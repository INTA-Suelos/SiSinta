# encoding: utf-8
class UsuariosController < AutorizadoController
  autocomplete :usuario, :nombre, full: true, extra_data: [:email]
  autocomplete :usuario, :email, full: true, extra_data: [:nombre]

  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource

  before_filter :evitar_escalada_de_privilegios, only: [:index, :update_varios]

  def index
    @usuarios = PaginadorDecorator.decorate apply_scopes(@usuarios)

    respond_with @usuarios
  end

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

  def destroy
    respond_with @usuario.destroy
  end

  def update_varios
    errores = Usuario.update(
      params[:usuarios].keys, params[:usuarios].values).reject do |u|
        u.errors.empty?
    end

    @usuarios = PaginadorDecorator.decorate apply_scopes(@usuarios)

    respond_with @usuarios, location: usuarios_path,
      notice: t('usuarios.update_varios.notice') do |format|
        if errores.any?
          flash[:alert] = t('usuarios.update_varios.alert')
        end
    end
  end

  private

    def usuario_params
      params.require(:usuario).permit :srid, :ficha_id, :idioma
    end

    def evitar_escalada_de_privilegios
      @usuarios = @usuarios.where('id <> ?', current_usuario.id)
      params[:usuarios].try :delete, current_usuario.id.to_s
    end
end
