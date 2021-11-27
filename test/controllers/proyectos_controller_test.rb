require 'test_helper'

describe ProyectosController do
  describe 'sin loguearse' do
    it 'accede a la lista de proyectos' do
      get :index

      must_respond_with :success
    end

    it 'muestra un proyecto' do
      get :show, id: create(:proyecto)

      must_respond_with :success
    end
  end

  describe 'autorizado' do
    let(:usuario) { loguearse }

    before { _(usuario).must_be :persisted? }

    it 'va a nuevo' do
      autorizar { get :new }

      must_respond_with :success
    end

    it 'crea un proyecto' do
      _(lambda do
        autorizar do
          post :create, proyecto: attributes_for(:proyecto)
        end
      end).must_change 'Proyecto.count'

      must_redirect_to proyecto_path(assigns(:proyecto))
    end

    it 'va a editar' do
      autorizar do
        get :edit, id: create(:proyecto, usuario: usuario)
      end

      must_respond_with :success
    end

    it 'actualiza un proyecto' do
      proyecto = create(:proyecto, usuario: usuario)

      autorizar do
        put :update, id: proyecto, proyecto: {
          nombre: 'un proyecto', cita: 'una cita', descripcion: 'una descripción'
        }
      end

      must_redirect_to proyecto_path(assigns(:proyecto))
      _(assigns(:proyecto).id).must_equal proyecto.id
      _(assigns(:proyecto).nombre).must_equal 'un proyecto'
      _(assigns(:proyecto).cita).must_equal 'una cita'
      _(assigns(:proyecto).descripcion).must_equal 'una descripción'
    end

    it 'elimina un proyecto' do
      proyecto = create(:proyecto, usuario: usuario)

      _(lambda do
        autorizar { delete :destroy, id: proyecto }
      end).must_change 'Proyecto.count', -1

      must_redirect_to proyectos_path
    end
  end
end
