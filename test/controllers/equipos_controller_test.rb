require 'test_helper'

describe EquiposController do
  it 'muestra la lista de equipos si está autorizado' do
    loguearse

    autorizar do
      get :index
    end

    must_respond_with :success
    _(assigns(:equipos)).wont_be :nil?
  end

  it 'va a nuevo si está autorizado' do
    loguearse

    autorizar do
      get :new
    end

    must_respond_with :success
  end

  it 'crea un equipo si está autorizado' do
    loguearse

    _(lambda do
      autorizar { post :create, equipo: attributes_for(:equipo) }
    end).must_change 'Equipo.count'

    must_redirect_to equipo_path(assigns(:equipo))
  end

  it 'muestra un equipo si está autorizado' do
    loguearse

    autorizar do
      get :show, id: create(:equipo)
    end

    must_respond_with :success
  end

  it 'va a editar si está autorizado' do
    usuario = loguearse
    equipo = create(:equipo, usuario: usuario)

    autorizar do
      get :edit, id: equipo
    end

    must_respond_with :success
  end

  it 'actualiza un equipo si está autorizado' do
    usuario = loguearse
    equipo = create(:equipo, usuario: usuario)

    autorizar do
      put :update, id: equipo, equipo: attributes_for(:equipo)
    end

    must_redirect_to equipo_path(assigns(:equipo))
  end

  it 'elimina un equipo si está autorizado' do
    usuario = loguearse
    equipo = create(:equipo, usuario: usuario)

    _(lambda do
      autorizar { delete :destroy, id: equipo }
    end).must_change 'Equipo.count', -1

    must_redirect_to equipos_path
  end

  it 'editar incluye tags para autocompletar' do
    usuario = loguearse

    autorizar do
      get :edit, id: create(:equipo, usuario: usuario)
    end

    must_select '#equipo_nuevo_miembro_id'
    must_select '#equipo_nuevo_miembro_email'
    must_select '#equipo_nuevo_miembro_nombre'
  end
end
