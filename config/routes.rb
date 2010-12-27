Testman::Application.routes.draw do


  
  get 'testsuites/:id/show_testcases' => 'testsuites#show_testcases', :as => :show_testcases
  get 'testsuites/:id/add_testcase/:testcase_id' => 'testsuites#add_testcase', :as => :add_testcase
  
  resources :testsuites do
    resources :testsuite_entries, :only => :destroy
  end

  get 'testcases/:testcase_id/moveup/:id' => 'teststeps#move_up', :as => :move_up
  get 'testcases/:testcase_id/movedown/:id' => 'teststeps#move_down', :as => :move_down
  resources :testcases do
    resources :teststeps
  end

  get 'projects/activatable_projects' => 'projects#activatable_projects'
  get 'projects/:id/activate' => 'projects#activate', :as => :activate_project
  resources :projects


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
  resources :users
  resources :user_sessions
  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'
  
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
  root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
