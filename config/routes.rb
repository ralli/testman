Testman::Application.routes.draw do
  resources :testsuiteruns do
    member do
      put 'show_all'
      put 'show_current'
      put 'set_all_ok'
      put 'set_all_failed'
      put 'step_failure'
      put 'step_ok'
    end
  end

  resources :testsuites do
    resources :testsuite_entries, :only => :destroy
    member do
      match 'sort_testcases'
      match 'run'
      get   'show_testcases'
      get   'show_add'
      post  'assign_testcase'
      post  'reorder_testcases'
      post  'remove_testcase'
      match 'search_testcases'
      put   'create_version'
    end
    collection do
      get   'search'
    end
  end

  resources :testcases do
    member do
      post 'sort_attachments'
      post 'sort_teststeps'
      put 'create_version'
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

  resources :users

  resources :user_sessions
  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  root :to => "welcome#index"
end

