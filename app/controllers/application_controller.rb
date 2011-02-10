class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user, :current_project

  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter :set_locale

  def set_locale
    if current_user.nil?
      I18n.locale = params[:locale]
    else
      I18n.locale = current_user.try(:locale)
    end
  end

  def default_url_options(options = {})
    if current_user.nil?
      {:locale => I18n.locale }
    else
      options
    end
  end

  def permission_denied
    flash[:error] = I18n::t('controller.application.permission_denied')
    redirect_to root_url
  end

  def current_project
    current_user.try(:current_project)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = I18n::t('controller.application.must_be_logged_in')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = I18n::t('controller.application.must_be_logged_out')
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

