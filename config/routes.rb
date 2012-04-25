# -*- encoding : utf-8 -*-
Suelos::Application.routes.draw do

  get 'inicio/index'

  # Rutas para exportar a CSV
  get   'calicatas/preparar_csv'
  post  'calicatas/procesar_csv'
  get   'series/preparar_csv' => 'calicatas#preparar_csv'
  post  'series/procesar_csv' => 'calicatas#procesar_csv'

  # Autenticación en rack
  devise_for :usuarios

  # Para limitar las vistas a las calicatas que son modales
  get 'series' => 'calicatas#index', as: 'series'

  # Explicito la ruta para evitar que tome 'geo' como un :id
  get 'calicatas/geo'  => 'calicatas#geo'
  get 'series/geo'     => 'calicatas#geo', as: 'series'

  # Rutas en castellano (i.e. calicatas/nueva, calicatas/2/editar)
  m = { new: "nuevo", edit: "editar" }
  f = { new: "nueva", edit: "editar" }

  resources :calicatas, path_names: f do
    resources :analisis, path_names: m, except: [:create, :edit, :new, :update] do
      get 'edit', on: :collection
      put 'update', on: :collection
    end
  end
  resources :horizontes, path_names: m
  resources :grupos, only: :index, path_names: m do
    get 'autocompletar/:atributo' => 'grupos#autocompletar', on: :collection
  end
  resources :fases, only: :index, path_names: f do
    get 'autocompletar/:atributo' => 'fases#autocompletar', on: :collection
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'inicio#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
