# encoding: utf-8
require './test/test_helper'

class PerfilesControllerTest < ActionController::TestCase
  test "el test accede al controlador" do
    assert_instance_of PerfilesController, @controller
  end

  test "va a 'nuevo' si está autorizado" do
    loguearse_como 'Autorizado'

    get :new
    assert_response :success
  end

  test "crea un perfil si está autorizado" do
    loguearse_como 'Autorizado'

    assert_difference('Perfil.count', 1) do
      post :create, perfil: attributes_for(:perfil)
    end

    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "muestra un perfil si está autorizado" do
    loguearse_como 'Autorizado'

    @request.env["HTTP_REFERER"] = "/perfiles/"

    get :show, id: create(:perfil).to_param

    assert_response :success
  end

  test "va a 'editar' si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario)
    get :edit, id: perfil.to_param
    assert_response :success
  end

  test "actualiza un perfil si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario)

    @request.env["HTTP_REFERER"] = "/perfiles/#{perfil.to_param}"
    put :update, id: perfil.to_param, perfil: { observaciones: 'agudas' }
    assert_redirected_to perfil_path(assigns(:perfil))
    assert_equal 'agudas', assigns(:perfil).observaciones
  end

  test "elimina un perfil si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario)

    assert_difference('Perfil.count', -1) do
      delete :destroy, id: perfil.to_param
    end

    assert_redirected_to perfiles_path
  end

  test "accede a la lista de perfiles sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "accede a los datos en geoJSON sin loguearse" do
    assert_nil @controller.current_usuario
    @request.env["HTTP_REFERER"] = "/perfiles/"
    get :index, format: 'geojson'
    assert_response :success
  end

  test "va a 'editar_analiticos' si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario)

    get :editar_analiticos, id: perfil.to_param
    assert_response :success
    assert_not_nil assigns(:perfil), "Debe asignar el perfil en 'editar'"
  end

  test "actualiza todos los datos analíticos" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario)

    5.times do
      perfil.horizontes.create(attributes_for(:horizonte))
    end

    put :update_analiticos, id: perfil.to_param, perfil: {
      analiticos_attributes: {
        perfil.analiticos.first.id => attributes_for(:analitico, id: perfil.analiticos.first.id)
      }
    }

    assert_redirected_to perfil_analiticos_path(perfil)
  end

  test "rutea a editar_analiticos" do
    assert_routing({
      path: "/perfiles/345/editar_analiticos",
      method: :get
    },{
      controller: 'perfiles', action: 'editar_analiticos',
      id: '345'
    })
  end

  test "rutea a update_analiticos" do
    assert_routing({
      path: "/perfiles/123/update_analiticos",
      method: :put
    },{
      controller: 'perfiles', action: 'update_analiticos',
      id: '123'
    })
  end

  test "rutea a exportar" do
    assert_routing({
      path: "/perfiles/exportar",
      method: :get
    },{
      controller: 'perfiles', action: 'exportar'
    })
  end

  test "rutea a procesar" do
    assert_routing({
      path: "/perfiles/procesar",
      method: :post
    },{
      controller: 'perfiles', action: 'procesar'
    })
  end

  test "rutea a almacenar" do
    assert_routing({
      path: "/perfiles/almacenar",
      method: :put
    },{
      controller: 'perfiles', action: 'almacenar'
    })
  end

  test "almacena una lista de perfiles temporalmente" do
    loguearse_como 'Autorizado'
    @request.env["HTTP_REFERER"] = "/perfiles/"

    put :almacenar, perfil_ids: [1, 2, 3]

    assert_equal %w{1 2 3}, @controller.send(:perfiles_seleccionados),
      "Debe almacenar una lista de perfiles"
    assert_redirected_to exportar_perfiles_path
  end

  test "rutea a seleccionar_perfiles" do
    assert_routing({
      path: "/perfiles/seleccionar",
      method: :get
    },{
      controller: 'perfiles', action: 'seleccionar'
    })
  end

  test "el formulario incluye tags para autocompletar" do
    loguearse_como 'Autorizado'
    get :new

    assert_select '#perfil_serie_attributes_simbolo'
    assert_select '#perfil_serie_attributes_nombre'
  end

  test "autocompleta reconocedores" do
    loguearse_como 'Autorizado'
    perfil = create(:perfil, publico: true, reconocedores: 'juan salvo')

    get :autocomplete_reconocedores_name, term: 'jua'
    assert_response :success
    assert_equal  RocketTag::Tag.where("name like '%jua%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
  end

  test "autocompleta etiquetas" do
    loguearse_como 'Autorizado'
    perfil = create(:perfil, publico: true, etiquetas: 'tibio, caliente')

    get :autocomplete_etiquetas_name, term: 'io'
    assert_response :success
    assert_equal  RocketTag::Tag.where("name like '%io%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
  end
end
