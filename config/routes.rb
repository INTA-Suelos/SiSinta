# encoding: utf-8
# TODO buscar en todos los modelos con un index agregador
SiSINTA::Application.routes.draw do
  root to: 'inicio#index'
  get 'inicio/index'

  # Autenticación en rack
  devise_for :usuarios

  # Rutas en castellano (i.e. perfiles/nuevo, perfiles/2/editar)
  masculinos  = { new: "nuevo", edit: "editar" }
  femeninos   = { new: "nueva", edit: "editar" }

  scope 'permisos' do
    get ':modelo/:id' => 'permisos#edit',    as: 'permisos'
    put ':modelo/:id' => 'permisos#update',  as: 'permitir'
  end

  with_options path_names: masculinos do |r|

    r.resources :perfiles do

      r.resources :analiticos, only: :index

      collection do
        get   'exportar'
        post  'procesar'
        put   'almacenar'
        put   'derivar'
        match 'seleccionar', via: [:get, :post]
        get   'autocompletar_reconocedores' => 'perfiles#autocomplete_reconocedores_name'
        get   'autocompletar_etiquetas'     => 'perfiles#autocomplete_etiquetas_name'
      end

      member do
        get   'editar_analiticos'
        put   'update_analiticos'
      end

      r.resources :adjuntos do
        get 'descargar', on: :member
      end
    end

    r.resources :grupos do
      collection do
        get 'autocompletar_descripcion' => 'grupos#autocomplete_grupo_descripcion'
      end
    end

    r.resources :usuarios, only: [:index, :destroy, :update] do
      collection do
        put 'update_varios'
        get 'autocompletar_nombre'  => 'usuarios#autocomplete_usuario_nombre'
        get 'autocompletar_email'   => 'usuarios#autocomplete_usuario_email'
      end
    end

    r.resources :colores, only: [] do
      collection do
        get 'autocompletar_hvc' => 'colores#autocomplete_color_hvc'
        get 'autocompletar_rgb' => 'colores#autocomplete_color_rgb'
      end
    end

    r.resources :proyectos

    r.resources :equipos
  end

  with_options path_names: femeninos do |r|
    r.resources :fases do
      collection do
        get 'autocompletar_nombre' => 'fases#autocomplete_fase_nombre'
      end
    end

    r.resources :series do
      collection do
        get 'autocompletar_nombre' => 'series#autocomplete_serie_nombre'
        get 'autocompletar_simbolo' => 'series#autocomplete_serie_simbolo'
      end
    end

    r.resources :busquedas
  end
end
