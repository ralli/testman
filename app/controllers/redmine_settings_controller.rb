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
    redmine_project_id = params[:redmine_setting][:tracker_project_id]
    update_trigger = params[:update_trigger]
    unless update_trigger
      @redmine_projects = @redmine_setting.all_redmine_projects
      render 'choose_project'
    else
      redmine_project = Redmine::Project.find_by_id(@redmine_setting.site, @redmine_setting.user, @redmine_setting.password, redmine_project_id)
      @redmine_setting.tracker_project_name = redmine_project.name
      @redmine_setting.tracker_project_key = redmine_project.identifier
      if @redmine_setting.save
        redirect_to @project, :notice => I18n::t('controller.redmine_settings.successfully_created')
      else
        @redmine_projects = @redmine_setting.all_redmine_projects
        render 'choose_project'
      end
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @redmine_setting = @project.tracker_setting
    @redmine_projects = []
  end

  def update
    @project = Project.find(params[:project_id])
    @redmine_setting = @project.tracker_setting
    @redmine_setting.password = params[:redmine_setting][:password]
    if params[:update_trigger]
      @redmine_project_id = params[:redmine_setting][:tracker_project_id]
      redmine_project = Redmine::Project.find_by_id(@redmine_setting.site, @redmine_setting.user, @redmine_setting.password, @redmine_project_id)
      @redmine_setting.tracker_project_name = redmine_project.name
      @redmine_setting.tracker_project_key = redmine_project.identifier
      if @redmine_setting.update_attributes(params[:redmine_setting]) then
        redirect_to @project, :notice => t('controller.redmine_settings.successfully_updated')
      else
        @redmine_projects = @redmine_setting.all_redmine_projects
        render 'choose_project'
      end
    else
      @redmine_projects = @redmine_setting.all_redmine_projects
      render 'choose_project'
    end
  end
end
