authorization do
  role :admin do
    has_permission_on :projects, :to => :manage
  end

  role :guest do
    has_permission_on :projects, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
