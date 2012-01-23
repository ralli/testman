authorization do
  role :user do
    has_permission_on :users, :to => [:edit,:update, :show] do
       if_attribute :id => is { user.id }
    end
  end

  role :manager do
    includes :user
    has_permission_on [:projects, :testcases, :teststeps, :testsuites, :testsuiteruns, :testcase_attachments, :redmine_settings], :to => :manage
  end

  role :admin do
    includes :manager
    has_permission_on [:users], :to => :manage
  end

  role :tester do
    includes :user
    has_permission_on [:testsuiteruns], :to => :manage
    has_permission_on [:projects, :testcases, :teststeps, :testsuites, :testcase_attachments], :to => :read
  end

  role :guest do
    has_permission_on :users, :to => [:new, :create]
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end

