class TestsuiterunsController < ApplicationController
  before_filter :check_current_project
  filter_resource_access :additional_member => {:step_ok => :update, :step_failure => :update}

  def index
    @testruns = current_project.testsuiteruns.includes(:testsuite).order("testsuites.key").paginate(:page => params[:page])
  end

  def show
    @testrun = Testsuiterun.find(params[:id])
  end

  def step_ok
    Testsuiterun.transaction do
      @testrun = Testsuiterun.find(params[:id])
      @testrun.step(current_user, "ok")
    end
    render 'show'
  end


  def step_failure
    Testsuiterun.transaction do
      @testrun = Testsuiterun.find(params[:id])
      @testrun.step(current_user, "failed")
    end
    render 'show'      
  end
  
  private
  def check_current_project
    if current_project.nil?
      flash[:error] = 'Please select an active project first.'
      redirect_to root_url
    end
  end

end
