class ProjectsController < ApplicationController
  filter_resource_access :collection => [[:activatable_projects, :index], :index], :additional_member => {:activate => :update}

  def index
    @projects = Project.all
  end

  def activatable_projects
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => I18n::t('controller.projects.successfully_created')
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => I18n::t('controller.projects.successfully_updated')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => I18n::t('controller.projects.successfully_deleted')
  end

  def activate
    project = Project.find(params[:id])
    current_user.reload.update_attribute(:current_project, project)
    redirect_to root_url, :notice => I18n::t('controller.projects.project_activated', :project_name => project.name)
  end
end

