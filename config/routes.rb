Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }

  resources :internships
  resources :documents
  resources :applications
  resources :organizations
  resources :choices
  resources :users
  resources :profiles
  resources :recommendations

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get 'admin' => 'admin#index'
  get 'admin/debug' => 'admin#debug'
  get 'admin/stats' => 'admin#stats'
  get 'admin/fellowships(/:id)' => 'admin#fellowships', as: :fellowships_admin
  get 'admin/emails/:category' => 'admin#list_emails', as: :list_emails

  get 'fellowships' => 'fellowships#index'
  match 'fellowships/rank' => 'fellowships#rank', as: :fellowships_rank, via: [ :get, :post ]
  post 'fellowships/rank/save' => 'fellowships#save_choices', as: :fellowships_save

  get 'stipends' => 'stipends#index'
  match 'stipends/questions' => 'stipends#questions', as: :stipends_questions, via: [ :get, :post ]

  get 'confirmed' => 'main#confirmed'
  get 'faq' => 'main#faq'
  get 'apply' => 'main#apply', as: :apply
  get 'apply/:category' => 'main#apply_to', as: :apply_to
  match 'apply/:category/statement' => 'main#statement', as: :statement, via: [ :get, :post ]
  match 'rec/:rec_code' => 'main#rec', as: :rec, via: [ :get, :post ]
  match 'profile' => 'main#profile', as: :user_profile, via: [ :get, :post ]
  match 'document' => 'main#document', as: :user_document, via: [ :get, :post ]

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
