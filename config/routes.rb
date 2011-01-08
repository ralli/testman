Testman::Application.routes.draw do

  get "testsuiteruns/:id/step_ok" => "testsuiteruns#step_ok", :as => :step_ok
  get "testsuiteruns/:id/step_failure" => "testsuiteruns#step_failure", :as => :step_failure
  resources :testsuiteruns

  resources :testsuites do
    resources :testsuite_entries, :only => :destroy
    member do
      match 'sort_testcases'
      match 'run'
      get 'show_testcases'
      get 'show_add'
      post 'assign_testcase'
      post 'reorder_testcases'
      post 'remove_testcase'
      match 'search_testcases'
    end
  end

  resources :testcases do
    member do
      match 'sort_attachments'
      match 'sort_teststeps'
    end
    collection do
      get 'search'
    end
    resources :teststeps
    resources :testcase_attachments, :as => 'attachments'
  end

  resources :projects do
    get 'activatable_projects', :on => :collection
    get 'activate', :on => :member
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
