class UsersController < ApplicationController
  filter_resource_access :additional_member => { :sort_attachments => :update, :sort_teststeps => :update }
  filter_access_to :search, :require => :read
  filter_access_to :create_version, :require => :create

  def index
    @users = User.order('login').paginate(:page => params[:page])
  end

  def show
    @user = user.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to return_url, :notice => I18n::t('controller.users.successfully_created')
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to return_url, :notice => I18n::t('controller.users.successfully_updated')
    else
      render 'edit'
    end
  end

  def destroy
    if (params[:id] == current_user.to_param)
      redirect_to return_url, :notice => I18n::t('controller.users.cannot_delete_current')
      return
    end
    @user = User.find(params[:id])
    @user.destroy
    redirect_to return_url, :notice => I18n::t('controller.users.successfully_deleted')
  end
private
  def return_url
    if permitted_to? :manage, User.new
      users_url
    else
      root_url
    end
  end
end

