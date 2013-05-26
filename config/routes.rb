Schachclub::Application.routes.draw do
  opinio_model

    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'

  resources :blog_posts do
    opinio
    collection { put :mercury_create }
    member { put :mercury_update }
    member { get :publish }
  end

  resources :leagues

  resources :blog_articles
  # devise_for :users, :path_prefix => 'devise'
  devise_for :users, :controllers => {:sessions => 'sessions'}, :path_prefix => 'devise'
  devise_scope :user do
    match '/logout', to: 'sessions#destroy'
    match '/user_menu', to: 'sessions#user_menu'
  end

  resources :users
  resources :tournaments do
    member { get :start}
    member { get :finish}
    member { get :archive}
    member { post :edit_result}
  end

  resources :teams
  match 'teams/:id/announce_team' => 'teams#announce_team', :as => :announce_team, :method => :get

  get "welcome/index"
  get "impressum" => 'welcome#imprint'

  get "kalender" => 'events#index'
  resources :events do
    member { post :resize}
    member { post :move}
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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
