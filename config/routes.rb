Oiss::Application.routes.draw do

  resources :prices

  resources :groups

  resources :categories 

  resources :videos

  resources :contacts

  resources :company_introductions

  resources :pictures

  resources :news

  resources :descriptions
  get "admin/index"
  get "admin/logout"
  get "home/index"
  get "home/news"
  get "home/themes"
  get "home/groups"
  get "home/pictures"

  match "home/pictures" => "home#pictures"
  match "home/pictures/:id" => "home#pictures"
  match "home/company_introductions" => "home#company_introductions"
  match "home/company_introductions/:id" => "home#company_introductions"
  match "home/prices" => "home#prices"
  match "home/price_detail/:id" => "home#price_detail"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
     match 'home/news/:id' => 'home#news', :as=> :home_news_show
     match 'home/themes/:id' => 'home#themes', :as=> :home_themes_show

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
   root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
