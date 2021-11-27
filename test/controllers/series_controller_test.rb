require 'test_helper'

describe SeriesController do
  subject { create :serie }

  describe 'sin loguearse' do
    it 'accede a la lista de series' do
      get :index

      must_respond_with :success
    end

    it 'muestra una serie sin loguearse' do
      get :show, id: subject.to_param

      must_respond_with :success
    end

    it 'devuelve nombre para términos parciales' do
      termino = subject.nombre

      get :autocomplete_serie_nombre, term: termino

      must_respond_with :success
      _(json.size).must_equal Serie.where("nombre like '%#{termino}%'").size

      _(json.first.include?('id')).must_equal true
      _(json.first.include?('label')).must_equal true
      _(json.first.include?('value')).must_equal true
      _(json.first.include?('simbolo')).must_equal true
    end

    it 'devuelve símbolo para términos parciales' do
      termino = subject.simbolo

      get :autocomplete_serie_simbolo, term: termino

      must_respond_with :success
      _(json.size).must_equal Serie.where("simbolo like '%#{termino}%'").size

      _(json.first.include?('id')).must_equal true
      _(json.first.include?('label')).must_equal true
      _(json.first.include?('value')).must_equal true
      _(json.first.include?('nombre')).must_equal true
    end
  end

  describe 'autorizado' do
    let(:usuario) { loguearse }

    before { _(usuario).must_be :persisted? }

    it 'va a nueva' do
      autorizar { get :new }

      must_respond_with :success
    end

    it 'crea una serie' do
      _(lambda do
        autorizar { post :create, serie: attributes_for(:serie) }
      end).must_change 'Serie.count'

      must_redirect_to serie_path(assigns(:serie))
    end

    it 'va a editar si está autorizado' do
      autorizar do
        get :edit, id: create(:serie, usuario: usuario)
      end

      must_respond_with :success
    end

    it 'actualiza una serie si está autorizado' do
      autorizar do
        put :update, id: subject.to_param, serie: {
          nombre: 'de Fibonacci', simbolo: 'fi', descripcion: 'Larga'
        }
      end

      must_redirect_to serie_path(assigns(:serie))

      _(assigns(:serie).id).must_equal subject.id
      _(assigns(:serie).nombre).must_equal 'de Fibonacci'
      _(assigns(:serie).simbolo).must_equal 'fi'
      _(assigns(:serie).descripcion).must_equal 'Larga'
    end

    it 'elimina una serie si está autorizado' do
      _(subject).must_be :persisted?

      _(lambda do
        autorizar { delete :destroy, id: subject.to_param }
      end).must_change 'Serie.count', -1

      must_redirect_to series_path
    end
  end
end
