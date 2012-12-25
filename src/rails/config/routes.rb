PokusSorcery::Application.routes.draw do
  resources :ingredience_categories

  resources :recipe_categories

  resources :comments

  resources :articles

  get "home/index"
  get "home/success"
  get "home/error"
  get "index/home"
  get "user_sessions/new"
  get "user_sessions/create"
  get "user_sessions/destroy"
  get "marks/create"
  get "marks/index"
  get "recipes/fridge"
  get "recipes/newest"
  get "recipes/add_subrecipe"
  get "ingrediences/new_request"
  get "ingrediences/plain_list"

  root :to => 'home#index'
  resources :users do
    member do
      get :activate
    end
  end
  resources :user_sessions
  resources :recipes
  resources :articles
  resources :ingrediences

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'my_profile' => 'users#show'
  match 'my_recipes' => 'users#recipes'
  match 'my_articles' => 'users#articles'

  match 'recipes/:id/add_connected_article' => 'recipes#add_connected_article'
  match 'users/:id/recipes' => 'users#recipes'
  match 'users/:id/articles' => 'users#articles'
  match 'users/:id/block' => 'users#block'
  match 'users/:id/unblock' => 'users#unblock'
  match 'fridge' => 'recipes#fridge'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
