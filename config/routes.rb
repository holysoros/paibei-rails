Rails.application.routes.draw do


  # mobile routes
  get '/nfc/:nfc_id', to: 'mobile#nfc_show'
  get '/:qrcode_sn', to: 'mobile#qrcode_verify', constraints: {qrcode_sn: /[a-zA-Z0-9]{6}/}
  get '/:qrcode_sn/r', to: 'mobile#qrcode_verify_result', constraints: {qrcode_sn: /[a-zA-Z0-9]{6}/}
  get '/w/c', to: 'mobile#contact_us'
  get '/m/w/c', to: 'mobile#contact_us_m'
  get '/m/:qrcode_m_sn', to: 'mobile#qrcode_m_verify', constraints: {qrcode_m_sn: /[a-zA-Z0-9]{8}/}
  get '/m/:qrcode_m_sn/r', to: 'mobile#qrcode_m_verify_result', constraints: {qrcode_m_sn: /[a-zA-Z0-9]{8}/}

  # admin routes
  namespace :admin do
    get '/signin', to: 'sessions#new', as: 'signin'
    delete '/signout', to: 'sessions#destroy', as: 'signout'

    resources :products, :batches

    root 'products#index'

    resources :batches do
      resources :qrcodes
      resources :nfcs
    end

    resources :sessions, only: [:new, :create, :destroy]
    get '/signin',  to: 'sessions#new'
    delete '/signout', to: 'sessions#destroy'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
