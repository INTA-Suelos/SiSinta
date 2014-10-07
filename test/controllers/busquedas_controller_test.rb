# encoding: utf-8
require './test/test_helper'

class BusquedasControllerTest < ActionController::TestCase
  test 'accede a la lista de búsquedas sin loguearse' do
    get :index
    assert_response :success
  end

  test 'sin loguearse sólo ve búsquedas públicas en la lista' do
    create(:busqueda)
    publica = create(:busqueda, :publica)

    get :index

    assert_response :success
    assert assigns(:busquedas_publicas).include? publica
    assert assigns(:busquedas).empty?
  end

  test 'logueado ve sus búsquedas privadas en la lista' do
    usuario = loguearse
    privada = create(:busqueda, usuario: usuario)

    autorizar do
      get :index
    end

    assert_response :success
    assert assigns(:busquedas_publicas).empty?
    assert assigns(:busquedas).include? privada
  end

  test 'sus propias búsquedas públicas no aparecen con las demás' do
    usuario = loguearse
    publica = create(:busqueda, :publica, usuario: usuario)

    autorizar do
      get :index
    end

    assert_response :success
    refute assigns(:busquedas_publicas).include? publica
    assert assigns(:busquedas).include? publica
  end

  test 'va a nuevo sin loguearse' do
    get :new

    assert_response :success
  end

  test 'hace una búsqueda sin loguearse' do
    consulta = build(:busqueda, :primeros_perfiles).consulta

    post :create, q: consulta

    assert_redirected_to seleccionar_perfiles_path(q: consulta)
  end

  test 'hace una búsqueda y la guarda' do
    usuario = loguearse
    busqueda = attributes_for(:busqueda, :publica, usuario: usuario)
    consulta = build(:busqueda, :primeros_perfiles).consulta

    post :create, busqueda: busqueda, q: consulta

    assert_redirected_to busqueda_path(assigns(:busqueda))

    assert_equal busqueda[:nombre], assigns(:busqueda).nombre
    assert_equal busqueda[:publico], assigns(:busqueda).publica
    assert_equal usuario, assigns(:busqueda).usuario
    assert_equal consulta, assigns(:busqueda).consulta
  end

  test 'muestra una búsqueda sin loguearse' do
    busqueda = create(:busqueda, :publica)

    get :show, id: busqueda

    assert_redirected_to seleccionar_perfiles_path(busqueda: busqueda.nombre, q: busqueda.consulta)
  end

  test 'va a editar si está autorizado' do
    usuario = loguearse

    autorizar do
      get :edit, id: create(:busqueda, usuario: usuario)
    end

    assert_response :success
  end

  test 'actualiza una búsqueda si está autorizado' do
    usuario = loguearse
    busqueda = create(:busqueda, usuario: usuario)

    autorizar do
      put :update, id: busqueda, busqueda: { nombre: 'uno nuevo' }
    end

    assert_redirected_to busqueda_path(assigns(:busqueda))
    assert_equal busqueda.id, assigns(:busqueda).id
    assert_equal 'uno nuevo', assigns(:busqueda).nombre
  end

  test 'elimina una busqueda si está autorizado' do
    usuario = loguearse
    busqueda = create(:busqueda, usuario: usuario)

    assert_difference('Busqueda.count', -1) do
      autorizar do
        delete :destroy, id: busqueda
      end
    end

    assert_redirected_to busquedas_path
  end
end
