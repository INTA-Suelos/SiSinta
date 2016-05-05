class FichasController < ApplicationController
  # Guardamos el id de la ficha para la siguiente solicitud y redirigimos al
  # origen si el request es html
  def seleccionar
    session[:ficha] = ficha_params[:id]
    redirect_to params[:origen]
  end

  protected

  def ficha_params
    params.require(:ficha).permit :id
  end
end
