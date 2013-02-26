# encoding: utf-8
require './test/test_helper'

class AnaliticosControllerTest < ActionController::TestCase

  setup do
    loguearse_como :autorizado
    @perfil = create(:perfil)
    5.times do
      @perfil.analiticos.create(attributes_for(:analitico))
    end
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/analiticos"
  end

  test "rutea a editar_todos" do
    assert_routing({
      path: "/perfiles/#{@perfil.to_param}/analiticos/editar_todos",
      method: :get
    },{
      controller: 'analiticos', action: 'editar_todos',
      perfil_id: @perfil.to_param
    })
  end

  test "rutea a update_todos" do
    assert_routing({
      path: "/perfiles/#{@perfil.to_param}/analiticos/update_todos",
      method: :put
    },{
      controller: 'analiticos', action: 'update_todos',
      perfil_id: @perfil.to_param
    })
  end

  test "debería ir al índice de analíticos si está autorizado" do
    get :index, perfil_id: @perfil.to_param
    assert_response :success
    perfil = assigns(:perfil)
    analiticos = assigns(:analiticos)
    assert_not_nil perfil, "No asigna el perfil en el index"
    assert_not_nil analiticos, "No asigna los analíticos en el index"
    assert_equal analiticos.sort, perfil.analiticos.sort
  end

  test "debería ir a 'editar todos' si está autorizado" do
    get :editar_todos, perfil_id: @perfil.to_param
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna el perfil en 'editar'"
    assert_not_nil assigns(:analiticos), "No asigna los analíticos en 'editar'"
  end

  test "debería actualizar los analíticos de a varios" do
    put :update_todos, perfil_id: @perfil.to_param, perfil: attributes_for(:perfil)

    # FIXME Está redirigiendo pero el test falla :|
    assert_redirected_to perfil_analiticos_path(@perfil)
  end

end
