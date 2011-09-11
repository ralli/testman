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

  def current_user
    return @current_user if defined?(@current_user)
    return nil unless session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

