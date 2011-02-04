class WelcomeController < ApplicationController
  def index
    if current_user.nil?
      @user_session = UserSession.new
    else
      @user_session = nil
      @project_statistic = nil
      @project_statistic = ProjectStatistic.new(current_project) if current_project
    end
  end

end

