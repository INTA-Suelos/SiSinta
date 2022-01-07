require 'test_helper'

describe FasesController do
  subject { create :fase }

  describe 'sin loguearse' do
    it 'autocompleta nombre' do
      termino = subject.nombre

      get :autocomplete_fase_nombre, term: termino

      must_respond_with :success
      _(json.size).must_equal Fase.where("nombre like '%#{termino}%'").size

      _(json.first.include?('id')).must_equal true
      _(json.first.include?('label')).must_equal true
      _(json.first.include?('value')).must_equal true
    end
  end

  describe 'logueado' do
    before { loguearse }

    it 'va a nueva si está autorizado' do
      autorizar { get :new }

      must_respond_with :success
    end

    it 'crea una fase si está autorizado' do
      _(lambda do
        autorizar { post :create, fase: attributes_for(:fase) }
      end).must_change 'Fase.count', 1

      must_redirect_to fase_path(assigns(:fase))
    end

    it 'va a editar si está autorizado' do
      autorizar do
        get :edit, id: subject.to_param
      end

      must_respond_with :success
    end

    it 'actualiza una fase si está autorizado' do
      params = attributes_for(:fase)

      autorizar do
        put :update, id: subject.to_param, fase: params
      end

      must_redirect_to fase_path(assigns(:fase))
      _(assigns(:fase).id).must_equal subject.id
      _(assigns(:fase).nombre).must_equal params[:nombre]
      _(assigns(:fase).codigo).must_equal params[:codigo]
    end
  end
end
