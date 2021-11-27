require 'test_helper'

describe GruposController do
  subject { create :grupo }

  describe 'sin loguearse' do
    it 'autocompleta descripción' do
      termino = create(:grupo).descripcion

      get :autocomplete_grupo_descripcion, term: termino

      must_respond_with :success
      _(json.size).must_equal Grupo.where("descripcion like '%#{termino}%'").size

      _(json.first.include?('id')).must_equal true
      _(json.first.include?('label')).must_equal true
      _(json.first.include?('value')).must_equal true
    end
  end

  describe 'logueado' do
    before { loguearse }

    it 'va a nuevo si está autorizado' do
      autorizar { get :new }

      must_respond_with :success
    end

    it 'crea un grupo si está autorizado' do
      _(lambda do
        autorizar do
          post :create, grupo: attributes_for(:grupo)
        end
      end).must_change 'Grupo.count', 1

      must_redirect_to grupo_path(assigns(:grupo))
    end

    it 'va a editar si está autorizado' do
      autorizar do
        get :edit, id: subject.to_param
      end

      must_respond_with :success
    end

    it 'actualiza un grupo si está autorizado' do
      params = attributes_for(:grupo)

      autorizar do
        put :update, id: subject.to_param, grupo: params
      end

      must_redirect_to grupo_path(assigns(:grupo))
      _(assigns(:grupo).id).must_equal subject.id
      _(assigns(:grupo).descripcion).must_equal params[:descripcion]
      _(assigns(:grupo).codigo).must_equal params[:codigo]
    end
  end
end
