# encoding: utf-8
require './test/test_helper'

class PerfilesControllerTest < ActionController::TestCase

  test "debería acceder al controlador" do
    assert_instance_of PerfilesController, @controller
  end

  test "debería ir a 'nuevo' si está autorizado" do
    loguearse_como :autorizado

    get :new
    assert_response :success
  end

  test "debería crear un perfil si está autorizado" do
    loguearse_como :autorizado

    assert_difference('Perfil.count', 1) do
      post :create, perfil: attributes_for(:perfil)
    end

    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "debería mostrar un perfil si está autorizado" do
    loguearse_como :autorizado

    @request.env["HTTP_REFERER"] = "/perfiles/"

    get :show, id: create(:perfil).to_param

    assert_response :success
  end

  test "debería ir a 'editar' si está autorizado" do
    loguearse_como :autorizado

    get :edit, id: create(:perfil).to_param
    assert_response :success
  end

  test "debería actualizar un perfil si está autorizado" do
    loguearse_como :autorizado

    perfil = create(:perfil)
    @request.env["HTTP_REFERER"] = "/perfiles/#{perfil.to_param}"
    put :update, id: perfil.to_param, perfil: attributes_for(:perfil)
    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "debería eliminar un perfil si está autorizado" do
    loguearse_como :autorizado

    perfil = create(:perfil)
    assert_difference('Perfil.count', -1) do
      delete :destroy, id: perfil.to_param
    end

    assert_redirected_to perfiles_path
  end

  test "debería poder acceder a la lista de perfiles sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "debería poder acceder a los datos en geoJSON sin loguearse" do
    assert_nil @controller.current_usuario
    @request.env["HTTP_REFERER"] = "/perfiles/"
    get :geo, format: :json
    assert_response :success
  end

  test "debería devolver numero para términos parciales" do
    loguearse_como :autorizado
    termino = create(:perfil).numero

    get :autocompletar, atributo: 'numero', term: termino
    assert_response :success
    assert_equal  Perfil.where("numero like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('numero'), "debe devolver el número"
  end

  test "debería ir a 'editar todos' si está autorizado" do
    loguearse_como :autorizado
    perfil = create(:perfil)

    get :editar_analiticos, id: perfil.to_param
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna el perfil en 'editar'"
  end

  test "debería actualizar los analíticos de a varios" do
    loguearse_como :autorizado

    perfil = create(:perfil)
    5.times do
      perfil.horizontes.create(attributes_for(:horizonte))
    end

    # TODO por qué me dice que analitico.horizonte es nil?
    put :update_analiticos, id: perfil.to_param, perfil: {
      analiticos_attributes: { perfil.analiticos.first.id => attributes_for(:analitico) }
    }

    assert_redirected_to perfil_analiticos_path(perfil)
  end

  test "rutea a editar_todos" do
    perfil = create(:perfil)
    assert_routing({
      path: "/perfiles/#{perfil.to_param}/editar_analiticos",
      method: :get
    },{
      controller: 'perfiles', action: 'editar_analiticos',
      id: perfil.to_param
    })
  end

  test "rutea a update_todos" do
    perfil = create(:perfil)
    assert_routing({
      path: "/perfiles/#{perfil.to_param}/update_analiticos",
      method: :put
    },{
      controller: 'perfiles', action: 'update_analiticos',
      id: perfil.to_param
    })
  end

end
