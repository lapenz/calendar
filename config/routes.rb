Rails.application.routes.draw do

  resources :services
  resources :providers_services
  resources :appointments do
    collection do
      get 'checkout'
      post 'hours'
      post 'create_appointment'
      get 'resume'
      post 'check'
    end

    member do
      get 'schedule'
    end

  end
  resources :companies_services
  resources :opening_hours
  resources :services
  resources :clients do
    collection do
      get 'findByEmail'
      get 'findByName'
    end
  end
  resources :providers
  resources :settings
  resources :companies do
    collection do
      get 'details'
    end
  end
  resources :providers
  resources :settings

  post '/landing_page/contact'

  get '/help', to: 'help#index'

  match '/', to: 'landing_page#home', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'companies#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to => "landing_page#home"

  devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations" }

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
