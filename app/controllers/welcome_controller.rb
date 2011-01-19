class WelcomeController < ApplicationController
  def index
    if current_user.nil?
      @user_session = UserSession.new
    else
      @user_session = nil
    end
  end

end
