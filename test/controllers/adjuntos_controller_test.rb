# encoding: utf-8
require './test/test_helper'

class AdjuntosControllerTest < ActionController::TestCase
  test "rutea a index" do
    assert_routing({
      path: "/perfiles/1/adjuntos",
      method: :get
    },{
      controller: 'adjuntos', action: 'index',
      perfil_id: '1'
    })
  end

  test "rutea a show" do
    assert_routing({
      path: "/perfiles/1/adjuntos/2",
      method: :get
    },{
      controller: 'adjuntos', action: 'show',
      perfil_id: '1', id: '2'
    })
  end

  test "rutea a descargar" do
    assert_routing({
      path: "/perfiles/1/adjuntos/2/descargar",
      method: :get
    },{
      controller: 'adjuntos', action: 'descargar',
      perfil_id: '1', id: '2'
    })
  end

  test "muestra los adjuntos del perfil" do
    usuario = loguearse
    perfil = create(:perfil, usuario: usuario)
    3.times do
      create(:adjunto, perfil: perfil)
    end

    autorizar do
      get :index, perfil_id: perfil.id
    end

    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert_not_nil assigns(:adjuntos), "No asigna @adjuntos"
    assert_equal perfil.adjuntos.count, assigns(:adjuntos).count
  end

  test "sólo muestra los adjuntos del perfil solicitado" do
    loguearse

    autorizar do
      get :index, perfil_id: create(:perfil).id
    end

    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert assigns(:adjuntos).empty?, "Asigna @adjuntos"
  end

  test "va a 'editar' si está autorizado" do
    usuario = loguearse
    perfil = create(:perfil, usuario: usuario)
    adjunto = perfil.adjuntos.create attributes_for(:adjunto)

    autorizar do
      get :edit, id: adjunto, perfil_id: perfil.id
    end

    assert_response :success
    assert_not_nil assigns(:perfil), "Debe asignar @perfil"
    assert_not_nil assigns(:adjunto), "Debe asignar @adjunto"
  end

  test "actualizar un adjunto si está autorizado" do
    usuario = loguearse
    perfil = create(:perfil, usuario: usuario)
    adjunto = perfil.adjuntos.create attributes_for(:adjunto)

    autorizar do
      put :update, id: adjunto, adjunto: { notas: 'de alevosía' }, perfil_id: perfil.id
    end

    assert_redirected_to perfil_adjuntos_path(perfil)
    assert_equal 'de alevosía', adjunto.reload.notas
  end
end
