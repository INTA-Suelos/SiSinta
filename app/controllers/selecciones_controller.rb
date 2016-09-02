class SeleccionesController < ApplicationController
  def create
    ubicaciones = Ubicacion.en_caja(noreste: params[:noreste], sudoeste: params[:sudoeste])

    # Limita a perfiles públicos hasta que se muestren más en el mapa
    publicas = ubicaciones.joins(:perfil).where(perfil: { publico: true })

    # Almacena en la sesión los perfiles seleccionados
    session[:perfiles_seleccionados] = publicas.pluck(:perfil_id).uniq

    # Si falla algo podemos enviar tipo: 'error'
    render json: { tipo: 'notice', mensaje: t('.perfiles_seleccionados', count: publicas.count) }
  end
end
