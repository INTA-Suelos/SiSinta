class SeleccionesController < ApplicationController
  def create
    ubicaciones = Ubicacion.en_caja(noreste: params[:noreste], sudoeste: params[:sudoeste])

    # Limita a perfiles públicos hasta que se muestren más en el mapa
    publicas = ubicaciones.joins(:perfil).where(perfil: { publico: true })

    # Almacena en la sesión los perfiles seleccionados
    # TODO Unificar funcionamiento de "sumar perfiles" cuando haya forma de
    # limpiar
    session[:perfiles_seleccionados] = publicas.pluck(:perfil_id).uniq

    # Si falla algo podemos enviar tipo: 'error'
    render json: { tipo: 'notice', mensaje: t('.perfiles_seleccionados', count: publicas.count) }
  end

  def almacenar_por_provincias
    ubicaciones = Ubicacion.en_provincias(seleccion_params[:provincia_ids])
    perfiles = Perfil.accessible_by(current_ability).joins(:ubicacion).where(ubicacion: { id: ubicaciones.ids }).ids

    # TODO Tal vez abstraer la seleccion actual en un objeto
    # Perfiles recién seleccionados y los ya viejos
    (self.perfiles_seleccionados += perfiles).uniq!

    # TODO redirigir según el botón apretado en +seleccionar+ (e.g. puede
    # dirigir a exportar, a eliminar, a rrrear)
    redirect_to exportar_perfiles_path
  end

  protected

  # FIXME Usar en todas las acciones
  def seleccion_params
    params.require(:seleccion).permit(
      provincia_ids: []
    )
  end

  # TODO Tal vez abstraer la seleccion actual en un objeto
  def perfiles_seleccionados=(perfiles)
    session[:perfiles_seleccionados] = perfiles
  end

  def perfiles_seleccionados
    Array.wrap session[:perfiles_seleccionados]
  end
end
