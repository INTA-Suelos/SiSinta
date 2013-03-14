class BusquedasController < ApplicationController
  has_scope :search, as: :q, type: :hash, default: { }

  def index
    @busquedas = Busqueda.all
    respond_with(@busquedas)
  end

  def show
    @busqueda = Busqueda.find(params[:id])
    respond_with(@busqueda)
  end

  def new
    @perfiles = Perfil.ransack
    @busqueda = Busqueda.new
    respond_with(@busqueda)
  end

  def edit
    @busqueda = Busqueda.find(params[:id])
  end

  def create
    @busqueda = Busqueda.new(params[:busqueda])
    @busqueda.save
    respond_with(@busqueda)
  end

  def update
    @busqueda = Busqueda.find(params[:id])
    @busqueda.update_attributes(params[:busqueda])
    respond_with(@busqueda)
  end

  def destroy
    @busqueda = Busqueda.find(params[:id])
    @busqueda.destroy
    respond_with(@busqueda)
  end
end
