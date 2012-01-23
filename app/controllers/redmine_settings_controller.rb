require 'redmine/project'

class RedmineSettingsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @redmine_setting = RedmineSetting.new
    @redmine_projects = []
    #@redmine_projects = RedmineProjects
  end

  def create
    @project = Project.find(params[:project_id])
    @redmine_setting = RedmineSetting.new(params[:redmine_setting])
    @redmine_setting.project = @project
    @redmine_setting.password = params[:redmine_setting][:password]
    @redmine_project_id = @redmine_setting.tracker_project_id
    if @redmine_project_id.nil?
      @redmine_projects = Redmine::Project.find_all(@redmine_setting.site, @redmine_setting.user, @redmine_setting.password)
      render 'choose_project'
    else
      if @redmine_setting.save
        redirect_to @project, :notice => I18n::t('controller.redmine_settings.successfully_created')
      else
        @redmine_projects = Redmine::Project.find_all(@redmine_setting.site, @redmine_setting.user, @redmine_setting.password)
        render 'choose_project'
      end
    end
  end
end
