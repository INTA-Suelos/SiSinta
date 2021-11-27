require 'test_helper'

describe BusquedasController do
  describe 'no logueado' do
    it 'accede a la lista de búsquedas' do
      get :index

      must_respond_with :success
    end

    it 'sólo ve búsquedas públicas en la lista' do
      create(:busqueda)
      publica = create(:busqueda, :publica)

      get :index

      must_respond_with :success
      _(assigns(:busquedas_publicas).include?(publica)).must_equal true
      _(assigns(:busquedas)).must_be :empty?
    end

    it 'va a nuevo' do
      get :new

      must_respond_with :success
    end

    it 'hace una búsqueda' do
      consulta = build(:busqueda, :primeros_perfiles).consulta

      post :create, q: consulta

      must_redirect_to seleccionar_perfiles_path(q: consulta)
    end

    it 'muestra una búsqueda' do
      busqueda = create(:busqueda, :publica)

      get :show, id: busqueda

      must_redirect_to seleccionar_perfiles_path(busqueda: busqueda.nombre, q: busqueda.consulta)
    end
  end

  describe 'logueado' do
    let(:usuario) { loguearse }

    it 've sus búsquedas privadas en la lista' do
      privada = create(:busqueda, usuario: usuario)

      autorizar do
        get :index
      end

      must_respond_with :success
      _(assigns(:busquedas_publicas)).must_be :empty?
      _(assigns(:busquedas).include?(privada)).must_equal true
    end

    it 'sus propias búsquedas públicas no aparecen con las demás' do
      publica = create(:busqueda, :publica, usuario: usuario)

      autorizar do
        get :index
      end

      must_respond_with :success
      _(assigns(:busquedas_publicas).include?(publica)).must_equal false
      _(assigns(:busquedas).include?(publica)).must_equal true
    end

    it 'hace una búsqueda y la guarda' do
      busqueda = attributes_for(:busqueda, :publica, usuario: usuario)
      consulta = build(:busqueda, :primeros_perfiles).consulta

      post :create, busqueda: busqueda, q: consulta

      must_redirect_to busqueda_path(assigns(:busqueda))

      _(assigns(:busqueda).nombre).must_equal busqueda[:nombre]
      _(assigns(:busqueda).publica).must_equal busqueda[:publico]
      _(assigns(:busqueda).usuario).must_equal usuario
      _(assigns(:busqueda).consulta).must_equal consulta
    end

    it 'va a editar si está autorizado' do
      autorizar do
        get :edit, id: create(:busqueda, usuario: usuario)
      end

      must_respond_with :success
    end

    it 'actualiza una búsqueda si está autorizado' do
      busqueda = create(:busqueda, usuario: usuario)

      autorizar do
        put :update, id: busqueda, busqueda: { nombre: 'uno nuevo' }
      end

      must_redirect_to busqueda_path(assigns(:busqueda))
      _(assigns(:busqueda).id).must_equal busqueda.id
      _(assigns(:busqueda).nombre).must_equal 'uno nuevo'
    end

    it 'elimina una busqueda si está autorizado' do
      busqueda = create(:busqueda, usuario: usuario)

      _(lambda do
        autorizar { delete :destroy, id: busqueda }
      end).must_change 'Busqueda.count', -1

      must_redirect_to busquedas_path
    end
  end
end
