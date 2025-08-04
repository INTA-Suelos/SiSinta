require 'test_helper'

describe PerfilesController do
  before { create :ficha, :default }

  describe 'autorizado' do
    let(:usuario) { loguearse_como 'Autorizado' }

    before { _(usuario).must_be :persisted? }

    it 'va a nuevo' do
      get :new

      must_respond_with :success
    end

    it 'crea un perfil' do
      _(lambda do
        post :create, perfil: attributes_for(:perfil)
      end).must_change 'Perfil.count', 1

      must_redirect_to perfil_path(assigns(:perfil))
    end

    it 'muestra un perfil' do
      get :show, id: create(:perfil).to_param

      must_respond_with :success
    end

    it 'va a editar' do
      perfil = create(:perfil, usuario: usuario)

      get :edit, id: perfil.to_param

      must_respond_with :success
    end

    it 'actualiza un perfil' do
      perfil = create(:perfil, usuario: usuario)

      put :update, id: perfil.to_param, perfil: { observaciones: 'agudas' }

      must_redirect_to perfil_path(assigns(:perfil))
      _(assigns(:perfil).observaciones).must_equal 'agudas'
    end

    it 'elimina un perfil' do
      perfil = create(:perfil, usuario: usuario)

      _(lambda do
        delete :destroy, id: perfil.to_param
      end).must_change 'Perfil.count', -1

      must_redirect_to perfiles_path
    end

    it 'va a editar_analiticos' do
      perfil = create(:perfil, usuario: usuario)

      get :editar_analiticos, id: perfil.to_param

      must_respond_with :success
      _(assigns(:perfil)).wont_be :nil?
    end

    it 'actualiza todos los datos analíticos' do
      perfil = create(:perfil, usuario: usuario)
      perfil.horizontes.create(attributes_for(:horizonte))
      analitico = attributes_for(:analitico, :con_datos, id: perfil.analiticos.first.id)

      put :update_analiticos, id: perfil.to_param, perfil: {
        analiticos_attributes: { '0' => analitico }
      }
      perfil.reload

      must_redirect_to perfil_analiticos_path(perfil)

      _(perfil.analiticos.first.registro).must_equal analitico[:registro]
      _(perfil.analiticos.first.humedad.to_f).must_equal analitico[:humedad]
      _(perfil.analiticos.first.s.to_f).must_equal analitico[:s]
      _(perfil.analiticos.first.t.to_f).must_equal analitico[:t]
      _(perfil.analiticos.first.ph_pasta.to_f).must_equal analitico[:ph_pasta]
      _(perfil.analiticos.first.ph_h2o.to_f).must_equal analitico[:ph_h2o]
      _(perfil.analiticos.first.ph_kcl.to_f).must_equal analitico[:ph_kcl]
      _(perfil.analiticos.first.resistencia_pasta.to_f).must_equal analitico[:resistencia_pasta]
      _(perfil.analiticos.first.base_ca.to_f).must_equal analitico[:base_ca]
      _(perfil.analiticos.first.base_mg.to_f).must_equal analitico[:base_mg]
      _(perfil.analiticos.first.base_k.to_f).must_equal analitico[:base_k]
      _(perfil.analiticos.first.base_na.to_f).must_equal analitico[:base_na]
      _(perfil.analiticos.first.base_al.to_f).must_equal analitico[:base_al]
      _(perfil.analiticos.first.profundidad_muestra).must_equal analitico[:profundidad_muestra]
      _(perfil.analiticos.first.p_ppm).must_equal analitico[:p_ppm]
    end

    it 'almacena una lista de perfiles temporalmente' do
      put :almacenar, perfil_ids: [1, 2, 3]

      _(@controller.send(:perfiles_seleccionados)).must_equal %w{1 2 3}
      must_redirect_to exportar_perfiles_path
    end

    it 'el formulario incluye tags para autocompletar' do
      get :new

      must_select '#perfil_serie_attributes_simbolo'
      must_select '#perfil_serie_attributes_nombre'
    end

    it 'autocompleta reconocedores' do
      skip 'resolver después de actualizar la interfaz y la búsqueda'
    end

    it 'autocompleta etiquetas' do
      skip 'resolver después de actualizar la interfaz y la búsqueda'
    end
  end

  describe 'sin loguearse' do
    it 'accede a la lista de perfiles' do
      _(@controller.current_usuario).must_be :nil?

      get :index

      must_respond_with :success
    end

    it 'accede a los datos en geoJSON' do
      _(@controller.current_usuario).must_be :nil?
      create(:ubicacion, :con_perfil, :con_coordenadas)

      get :index, format: 'geojson'

      must_respond_with :success
      _(json['type']).must_equal 'FeatureCollection'
      _(json['features'].size).must_equal Perfil.geolocalizados.count
    end

    it 'devuelve sólo perfiles públicos' do
      _(@controller.current_usuario).must_be :nil?
      create(:ubicacion, :con_perfil, :con_coordenadas)
      publico = create(:ubicacion, :con_perfil, :con_coordenadas)
      publico.perfil.update_attribute :publico, true

      get :index, publicos: 'true', format: 'geojson'

      _(Perfil.count).wont_equal Perfil.publicos.count
      _(json['features'].size).must_equal Perfil.publicos.count
    end
  end

  describe 'geoJSON' do
    subject { create :perfil_para_geojson }

    it 'no muestra perfiles sin ubicación' do
      get :show, id: create(:perfil, publico: true).to_param, format: :geojson

      must_respond_with :no_content
    end

    it 'muestra perfiles geolocalizados' do
      get :show, id: subject.to_param, format: :geojson

      must_respond_with :success
      _(json['type']).must_equal 'FeatureCollection'
      _(json['features'].size).must_equal 1
    end

    it 'serializa la ubicación en geoJSON' do
      get :show, id: subject.to_param, format: :geojson

      _(json['features'].first['type']).must_equal 'Feature'
      geometria = json['features'].first['geometry']

      _(geometria['type']).must_equal 'Point'
      _(geometria['coordinates'].first).must_equal subject.ubicacion.x
      _(geometria['coordinates'].last).must_equal subject.ubicacion.y
    end

    it 'serializa todos los atributos' do
      get :show, id: subject.to_param, format: :geojson

      serializado = json['features'].first['properties']

      _(serializado['id']).must_equal subject.id
      _(serializado['numero']).must_equal subject.numero
      _(serializado['fecha']).must_equal subject.decorate.fecha
      _(serializado['clase']).must_equal subject.decorate.clase
      _(serializado['url']).must_equal perfil_url(subject)

      # Todas las llaves testeadas más la serie
      _(serializado.count).must_equal 6
    end

    it 'serializa la serie con nombre y url' do
      get :show, id: subject.to_param, format: :geojson

      serie_serializada = json['features'].first['properties']['serie']

      _(serie_serializada['nombre']).must_equal subject.serie.nombre
      _(serie_serializada['url']).must_equal serie_url(subject.serie)

      # Todas las llaves testeadas
      _(serie_serializada.count).must_equal 2
    end
  end
end
