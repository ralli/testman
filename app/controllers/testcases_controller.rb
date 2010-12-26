class TestcasesController < ApplicationController
  filter_resource_access
  before_filter :check_current_project
  
  def index
    @testcases = current_project.testcases.order(:id).paginate(:per_page => 10, :page => params[:page])
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
end
