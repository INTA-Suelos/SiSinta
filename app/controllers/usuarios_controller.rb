# encoding: utf-8
class UsuariosController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource

  before_filter :evitar_escalada_de_privilegios, only: [:index, :update_varios]

  def index
    @usuarios = PaginadorDecorator.decorate apply_scopes(@usuarios)
    respond_with @usuarios
  end

  def update
    current_usuario.update_attributes(params[:usuario])
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

    def evitar_escalada_de_privilegios
      @usuarios = @usuarios.where('id <> ?', current_usuario.id)
      params[:usuarios].try :delete, current_usuario.id.to_s
    end
end
