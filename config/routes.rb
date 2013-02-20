# encoding: utf-8
SiSINTA::Application.routes.draw do

  # TODO buscar en todos los modelos con un index agregador

  root to: 'inicio#index'
  get 'inicio/index'

  # Autenticación en rack
  devise_for :usuarios

  # Rutas en castellano (i.e. perfiles/nuevo, perfiles/2/editar)
  masculinos  = { new: "nuevo", edit: "editar" }
  femeninos   = { new: "nueva", edit: "editar" }

  get 'permisos/:modelo/:id' => 'permisos#edit',    as: 'permisos'
  put 'permisos/:modelo/:id' => 'permisos#update',  as: 'permitir'

  with_options path_names: masculinos do |r|

    r.resources :perfiles do
      collection do
        get   'geo'
        get   'exportar'
        post  'procesar_csv'
        put   'almacenar'
        get   'autocompletar/:atributo' => 'perfiles#autocompletar', as: 'autocompletar'
        get   'seleccionar'
      end

      r.resources :analisis, only: :index do
        collection do
          get 'edit'
          put 'update'
        end
      end

      r.resources :adjuntos do
        get 'descargar', on: :member
      end
    end

    r.resources :horizontes, only: :index do
      collection do
        get   'exportar'
        post  'procesar_csv'
      end
    end

    r.resources :grupos do
      collection do
        get 'autocompletar/:atributo' => 'grupos#autocompletar', as: 'autocompletar'
      end
    end

    r.resource :usuarios, only: [] do
      put 'configurar', on: :member
    end

    r.resources :colores, only: [] do
      collection do
        get 'autocompletar/:atributo' => 'colores#autocompletar', as: 'autocompletar'
      end
    end

    r.resources :proyectos

    r.resources :equipos

    scope "/admin" do
      r.resources :usuarios, only: [:index, :destroy] do
        put 'update', on: :collection
      end
    end

  end

  with_options path_names: femeninos do |r|

    r.resources :fases do
      collection do
        get 'autocompletar/:atributo' => 'fases#autocompletar', as: 'autocompletar'
      end
    end

    r.resources :series do
      collection do
        get 'autocompletar/:atributo' => 'series#autocompletar', as: 'autocompletar'
      end
    end

  end
end
