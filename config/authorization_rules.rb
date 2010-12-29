authorization do
  role :manager do
    has_permission_on [:projects, :testcases, :teststeps, :testsuites, :testruns], :to => :manage
  end

  role :admin do
    includes :manager
  end

  role :guest do
    has_permission_on [:projects], :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
