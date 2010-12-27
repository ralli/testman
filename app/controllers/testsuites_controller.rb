class TestsuitesController < ApplicationController
  filter_resource_access :additional_member => {:show_testcases => :update, :add_testcase => :update}
  
  def index
    @testsuites = current_project.testsuites
  end

  def new
    @testsuite = Testsuite.new_with_defaults
  end

  def create
    @testsuite = Testsuite.new_with_defaults(params[:testsuite])
    @testsuite.project = current_project
    @testsuite.created_by = current_user
    @testsuite.edited_by = current_user
    @testsuite.version = 1
    @testsuite.enabled = true
    
    if @testsuite.save
      redirect_to @testsuite, :notice => 'Testsuite successfully created.'
    else
      render 'new'
    end
  end

  def show
    @testsuite = Testsuite.find(params[:id])
    @testsuite_entries = @testsuite.testsuite_entries.includes(:testcase)
  end

  def edit
    @testsuite = Testsuite.find(params[:id])
  end

  def update
    @testsuite = Testsuite.find(params[:id])
    if @testsuite.update_attributes(params[:testsuite])
      redirect_to @testsuite, :notice => 'Successfully saved Testsuite.'
    else
      render 'edit'
    end
  end

  def destroy
    @testsuite = Testsuite.find(params[:id])
    @testsuite.destroy
    redirect_to testsuites_path, :notice => 'Successfully deleted Testsuite.'
  end

  def show_testcases
    @testsuite = Testsuite.find(params[:id])
    @testcases = current_project.testcases.paginate(:page => params[:page])
  end

  def add_testcase
    @testsuite = Testsuite.find(params[:id])
    @testcase = Testcase.find(params[:testcase_id])
    @testsuite.add_testcase(@testcase, current_user)
    redirect_to @testsuite, :notice => 'Successfully added testcase.'
  end
end
