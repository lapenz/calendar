Rails.application.routes.draw do

  resources :services
  resources :appointments do
    collection do
      get 'checkout'
      post 'hours'
      post 'create_appointment'
      get 'resume'
      post 'check'

    end

    member do
      delete 'cancelRepeat', as: 'cancel_repeat'
      delete 'cancel', as: 'cancel'
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
  resources :resources
  resources :companies do
    collection do
      get 'details'
      get 'promote'
    end
  end

  post '/landing_page/contact'

  get '/price', to: 'landing_page#price', as: 'landing_page_price'

  get '/help', to: 'help#index'

  match '/', to: 'landing_page#home', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'companies#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to => "landing_page#home"

  devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations" }

  require 'sidekiq/web'

  Rails.application.routes.draw do
     mount Sidekiq::Web => '/sidekiq'
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   invoice_items :products

  # Example resource route with options:
  #   invoice_items :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-invoice_items:
  #   invoice_items :products do
  #     invoice_items :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-invoice_items:
  #   invoice_items :products do
  #     invoice_items :comments
  #     invoice_items :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   invoice_items :posts, concerns: :toggleable
  #   invoice_items :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     invoice_items :products
  #   end
end
