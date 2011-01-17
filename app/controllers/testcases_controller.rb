class TestcasesController < ApplicationController
  filter_resource_access :additional_member => { :sort_attachments => :update, :sort_teststeps => :update }
  filter_access_to :search, :require => :read
  filter_access_to :create_version, :require => :create
  before_filter :check_current_project

  def index
    unless params[:tag].blank?
      @testcases = Testcase.find_tagged_with(params[:tag]).paginate(:per_page => 10, :page => params[:page])
    else
      @testcases = current_project.testcases.order(:id).paginate(:per_page => 10, :page => params[:page])
    end
    @tag_counts = Testcase.tag_counts
  end

  def search
    if(params[:search].blank?)
      @testcases = current_project.testcases.order(:id).paginate(:per_page => 10, :page => params[:page])
    else
      @testcases = Testcase.search(params[:search],
        :conditions => { :project_id => current_project.id },
        :per_page => 10, :page => params[:page])
    end
    @tag_counts = Testcase.tag_counts
    render 'index'
  end
  
  def show
    @testcase = Testcase.find(params[:id])
  end
  
  def new
    @testcase = Testcase.new_with_defaults
  end
  
  def create
    @testcase = Testcase.new(params[:testcase])
    @testcase.key = 'NEW'
    @testcase.project = current_project
    @testcase.created_by = current_user
    @testcase.edited_by = current_user
    if @testcase.save      
      redirect_to @testcase, :notice => "Your Test case has been successfully created."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @testcase = Testcase.find(params[:id])
  end
  
  def update
    @testcase = Testcase.find(params[:id])
    @testcase.edited_by = current_user
    if @testcase.update_attributes(params[:testcase])      
      redirect_to @testcase, :notice => "Successfully updated testcase."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @testcase = Testcase.find(params[:id])
    @testcase.destroy
    flash[:notice] = "Successfully destroyed testcase."
    redirect_to testcases_url
  end

  def check_current_project
    if current_project.nil?
      flash[:error] = 'Please select an active project first.'
      redirect_to root_url
    end
  end

  def sort_attachments
    params['attachment'].each_with_index do |id,idx|
      TestcaseAttachment.update_all(['position=?', idx+1], ['id=?', id.to_i])
    end
    render :nothing => true
  end

  def sort_teststeps
    @testcase = Testcase.find(params[:id])
    ids = params['teststeps']
    ids.delete_at(0) unless ids.empty?    
    ids.each_with_index do |id, idx|
      Teststep.update_all(['position=?', idx+1], ['id=?', id.to_i])
    end
    render :nothing => true
  end

  def create_version
    @testcase = Testcase.find(params[:id])
    @testcase = @testcase.create_version(current_user)
    redirect_to @testcase, :notice => 'New version created.'
  end
  
  private
  

end
