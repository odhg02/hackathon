Rails.application.routes.draw do
  resources :reviews
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :qnas do
    resources :qnacomments, only: [:create, :destroy], defaults: { format: 'js' }
  end
  resources :notices
  resources :posts do
    resources :comments, only: [:create, :destroy], defaults: { format: 'js' }
  end
  get '/posts/:membertype/search' => 'posts#search'
  root 'home#temp'
  get 'home/temp'
  get 'home/index'
  get 'home/matching'
  get '/mypages/:user_id' => "mypages#index"
  put '/mypages/:user_id/like', to: 'mypages#upvote', as: 'like_mypage'
  put '/mypages/:user_id/dislike', to: 'mypages#downvote', as: 'dislike_mypage'
  post '/posts/:post_id' =>"comments#create"
  get '/reviews/new/:post_id' => 'reviews#new'
  post '/reviews/:post_id' => 'reviews#create'
  post '/portfolios/create' => "portfolios#create"
  get '/portfolios/index'
  post '/tinymce_assets' => 'tinymce_assets#create'
  get '/mypage/index'
  get 'portfolios/edit' => "portfolios#edit"
  post '/portfolios/update' => "portfolios#update"
  get '/matching/:post_id/:name' => "posts#matching", :constraints  => { :name => /[0-z\.]+/ }
  devise_for :users
  
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
