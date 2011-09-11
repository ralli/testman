class UserSessionsController < ApplicationController
  def new
    if session[:user_id].nil?
      @user_session = UserSession.new
    else
      redirect_to root_url, :notice => I18n::t('controller.application.must_be_logged_out')
    end
  end

  def create
    debugger
    @user_session = UserSession.new(params[:user_session])
    if @user_session.valid?
      user = User.find_by_login(@user_session.login)
      if user && user.authenticate(@user_session.password)
         session[:user_id] = user.id
         redirect_to root_url, :notice => I18n::t('controller.user_sessions.logged_in')
      else
        flash.now.alert = "Invalid email or password"
        @user_session.password = nil
        render :action => :new
      end
    else
      render :action => :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => I18n::t('controller.user_sessions.logged_out')
  end
end

