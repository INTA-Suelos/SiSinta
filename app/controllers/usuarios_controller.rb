# encoding: utf-8
class UsuariosController < AutorizadoController

  before_filter :cargar_recursos
  before_filter :paginar, only: [:index]

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios.reject! { |u| u.id == current_usuario.id }
    @titulo = "Administración de usuarios y roles"
    respond_to do |format|
      format.html do
        if request.xhr?
          render :index,  layout: false,
                          locals: { usuarios: @usuarios.pagina(params[:pagina]) }
        end
      end
      format.json { render  json: @roles }
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.destroy
        flash[:success] = I18n.t 'messages.destroyed', model: Usuario
        format.html { volver }
        format.json { head :ok }
      else
        flash[:error] = @usuario.errors.messages
        format.html { volver }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios
  # PUT /usuarios
  def update
    error = false
    params[:usuarios].each_pair do |id, roles|
      unless Usuario.find(id).update_attributes(roles)
        error = true
      end
    end

    respond_to do |format|
      unless error
        flash[:notice] = I18n.t('messages.updated', model: 'los usuarios')
        format.html { volver }
        format.json { head :ok }
      else
        flash[:error] = I18n.t "messages.error"
        format.html { volver }
        format.json { render json: flash[:error], status: :unprocessable_entity }
      end
    end
  end

  private

    def cargar_recursos
      @roles = Rol.order('nombre ASC')
      @usuarios = Usuario.por_rol
    end

    def paginar
      @usuarios = @usuarios.pagina(params[:pagina])
    end

end
